require 'spec_helper'
require 'webmock/rspec'
require 'sidekiq/testing'

describe LinksController, type: :controller do
  include ActiveJob::TestHelper

  let(:link) { create(:link) }
  let(:user) { create(:user) }
  let(:attrs) { link.attributes }

  describe '#create' do
    it 'changes count if long_url does not exist in the url list' do
      attrs[:long_url] = 'http://yahoo.com'
      expect { post :create, link: attrs }.to change(Link, :count).by(1)
    end

    it 'does not change count if long_url string is empty' do
      attrs[:long_url] = ''
      expect { post :create, link: attrs }.to change(Link, :count).by(0)
    end

    it 'has flash notice if long_url is empty' do
      attrs[:long_url] = ''
      post :create, link: attrs
      expect(flash[:error]).to eq 'Your URL was not valid'
    end

    it 'redirects if long_url exists' do
      post :create, link: attrs
      expect(response).to redirect_to link_path(link.short_url)
    end
  end

  describe '#create when signed in' do
    before do
      allow(self.controller).to receive(:current_user).and_return(user)
    end

    it 'changes count if long_url does not exist in the url list' do
      attrs[:long_url] = 'http://yahoo.com'
      expect { post :create, link: attrs }.to change(user.links, :count).by(1)
    end

    it 'does not change count if long_url string is empty' do
      attrs[:long_url] = ''
      expect { post :create, link: attrs }.to change(Link, :count).by(0)
    end

    it 'changes count if long_url exists in the url list' do
      post :create, link: attrs
      expect { post :create, link: attrs }.to change(user.links, :count).by(1)
    end

    # it "tweets the url" do
    #  stub_tweet
    #  post :create, link: attrs.merge(tweet: '1')
    #  expect(WebMock).to have_requested(:post, /api.twitter.com/)
    it 'creates a TwitterJob with good long_url' do
      stub_tweet
        expect {
           post :create, link: attrs.merge(tweet: '1')
         }.to change(enqueued_jobs, :size).by(1)
    end

    it 'does not create a TwitterJob with an empty long_url' do
      attrs[:long_url] = ''
      stub_tweet
      expect {
        post :create, link: attrs.merge(tweet: '1')
      }.to change(enqueued_jobs, :size).by(0)
    end
  end

  describe '#show' do
    it 'is successful' do
      get :show, id: link.short_url
      expect(response).to be_success
    end
  end

  describe '#redirection' do
    it 'is successful' do
      get :redirection, id: link.short_url
      expect(response).to redirect_to link.long_url
    end
  end
end
