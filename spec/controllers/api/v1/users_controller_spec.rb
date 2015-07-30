
require 'spec_helper'

describe Api::V1::UsersController, type: :controller do

  # let(:link) { create(:link) }
  # let(:user) { create(:user) }
  let(:user) { FactoryGirl.create(:user) }
  let(:link) { FactoryGirl.create(:link, user: user) } # this doesn't seem to create an associated link

  describe "#show" do

    context "with a valid api_key" do
      let(:json) {JSON.parse(response.body) }

      before do
        # user.links.create(FactoryGirl.build(:link))
        get :show, api_key: user.api_key, id: user.id
        puts json
      end

      it "returns json" do
        puts "json = #{json}"
        expect(json.keys).to include 'user'
        expect(json['user'].keys).to include 'name'
        expect(json['user'].keys).to include 'email'
        expect(json['user'].keys).to include 'links'
        expect(json['user']['links'].first.keys).to include 'short_url'
        # expect(json['user']['links'].keys).to include 'long_url'
        # expect(json['user']['links'].keys).to include 'clicks'
      end

      it "doesn't return unwanted json elements" do
        expect(json['user'].keys).not_to include 'twitter_secret'
      end
    end
  end
end