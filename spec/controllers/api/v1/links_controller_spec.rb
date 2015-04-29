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

    context "with an invalid url parameter" do
      let(:json) { JSON.parse(response.body) }

      before do
        get :create, api_key: user.api_key, url: 'illformed url'
      end

      it "returns a JSON body with an error message" do
        expect(response.body).to include '{"errors":{"long_url":["is invalid"]}}'
      end
    end
  end
  
  describe "#show" do
    context "with invalid api_key" do
      it "returns a 401" do
        get :show, api_key: 'blank', id: link.id
        expect(response.code).to eq '401'
      end
    end
    
    context "with valid api_key" do
      let(:json) { JSON.parse(response.body) }

      before do
        link.update_attributes(:user_id => user.id)
        get :show, api_key: user.api_key, id: link.id

      end
      
      it "returns a JSON response" do
        expect(response.content_type).to eq "application/json"
      end
      
      it "returns a short url" do
        expect(json.keys).to include 'short_url'
        expect(json['short_url']).to include assigns(:link).short_url
      end
      
      it "returns a long url" do
        expect(json.keys).to include 'long_url'
        expect(json['long_url']).to include assigns(:link).long_url
      end
      
      it "returns clicks" do
        expect(json.keys).to include 'clicks'
        expect(json['clicks']).to eq(assigns(:link).clicks)
      end
      
      it "returns user name" do
        expect(json.keys).to include 'user'
        expect(json["user"].keys).to include "name"
        expect(json['user']['name']).to include user.name
      end
      
      it "returns user email" do
        expect(json.keys).to include 'user'
        expect(json["user"].keys).to include "email"
        expect(json['user']['email']).to include user.email
      end
      
    end
  end
end
