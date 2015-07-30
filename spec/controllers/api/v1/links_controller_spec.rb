require 'spec_helper'

describe Api::V1::LinksController, type: :controller do

  let(:link) { create(:link) }
  let(:user) { create(:user) }

  describe "#create" do
    context  "with invalid api_key" do
      it "returns a 401" do
        get :create, api_key: 'blank', url: 'http://test.com'
        expect(response.code).to eq '401'
      end
    end

    context "with a valid api_key" do
      let(:json) { JSON.parse(response.body) }

      before do
        get :create, api_key: user.api_key, url: 'http://test.com'
      end

      it "returns a JSON response" do
        expect(response.content_type).to eq "application/json"
      end

      it "returns a short url" do
        expect(json.keys).to include 'shorturl'
        expect(json['shorturl']).to include assigns(:link).short_url
      end
    end
  end

  describe "#show" do
    context  "with invalid api_key" do
      it "returns a 401" do
        get :show, id: link.short_url, api_key: 'blank'
        expect(response.code).to eq '401'
      end
    end

    context "with a valid api_key" do
      render_views

      let(:json) { JSON.parse(response.body) }

      before do
        # associate a user on a link first
        link.user = user
        link.save!
        get :show, id: link.short_url, api_key: user.api_key
      end

      it "returns a JSON response" do
        expect(response.content_type).to eq "application/json"
      end

      it "returns the correct JSON" do
        expect(json['short_url']).to include link.short_url
        expect(json['long_url']).to eq link.long_url
        expect(json['clicks']).to eq link.clicks
        expect(json['user']['name']).to eq user.name
        expect(json['user']['email']).to eq user.email
      end

      it "returns a JSON with the correct keys" do
        expect(json.keys).to contain_exactly('short_url', 'long_url', 'clicks', 'user')
        expect(json['user'].keys).to contain_exactly('name', 'email')
      end
    end
  end
end
