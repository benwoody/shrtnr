require 'spec_helper'

describe Api::V1::LinksController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let(:link) { create(:link, user_id: user.id) }

  describe "#show" do
    context "with a valid short_url" do
      let(:json) { JSON.parse(response.body) }

      it "returns the short_url" do
        get :show, id: link.short_url, api_key: user.api_key
        expect(json.keys).to include "shorturl", "long_url", "clicks", "user"
      end
    end

    context "with an invalid short_url" do
      let(:json) { JSON.parse(response.body) }

      it "returns an error message" do
        get :show, id: "notvalid", api_key: user.api_key
        expect(json.keys).to include "error"
      end
    end
  end

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

    context "with an invalid url parameter" do

      before do
        get :create, api_key: user.api_key, url: 'illformed url'
      end

      it "returns a JSON body with an error message" do
        expect(response.body).to include '{"errors":{"long_url":["is invalid"]}}'
      end
    end
  end
end
