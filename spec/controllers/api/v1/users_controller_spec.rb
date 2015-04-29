require 'spec_helper'

describe Api::V1::UsersController, type: :controller do

  let(:link) { create(:link) }
  let(:user) { create(:user) }

  describe "#show" do
    context "with invalid api_key" do
      it "returns a 401" do
        get :show, api_key: 'blank', id: user.id
        expect(response.code).to eq '401'
      end
    end

    context "with valid api_key" do
      let(:json) { JSON.parse(response.body) }
      
      before do
        link.update_attributes(user_id: user.id)
        get :show, api_key: user.api_key, id: user.id
      end

      it "returns a JSON response" do
        expect(response.content_type).to eq "application/json"        
      end

      it "returns the user's name" do
        expect(json.keys).to include 'user'
        expect(json['user'].keys).to include 'name'
        expect(json['user']['name']).to include user.name
      end

       it "returns the user's email" do
        expect(json.keys).to include 'user'
        expect(json['user'].keys).to include 'email'
        expect(json['user']['email']).to include user.email
      end

      it "returns the user's links" do
        expect(json.keys).to include 'user'
        expect(json['user'].keys).to include 'links'
        expect(json['user']['links']).to be_kind_of(Array)
        expect(json['user']['links'][0].keys).to include 'short_url'
        expect(json['user']['links'][0]['short_url']).to eq link.short_url
        expect(json['user']['links'][0].keys).to include 'long_url'
        expect(json['user']['links'][0]['long_url']).to eq link.long_url
        expect(json['user']['links'][0].keys).to include 'clicks'
        expect(json['user']['links'][0]['clicks']).to eq link.clicks
      end
      

    end

  end

end
