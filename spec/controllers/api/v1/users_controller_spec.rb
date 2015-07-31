require 'spec_helper'

describe Api::V1::UsersController, type: :controller do

  let(:user) { create(:user) }

  describe "#show" do
    context  "with invalid api_key" do
      it "returns a 401" do
        get :show, api_key: 'blank', id: user.id
        expect(response.code).to eq '401'
      end
    end

    context "with a valid api_key" do
      let(:json) { JSON.parse(response.body) }

      before do
        get :show, api_key: user.api_key, id: user.id
      end

      it "returns a JSON response" do
        expect(response.content_type).to eq "application/json"
      end

      it "returns name" do
        expect(json['user'].keys).to include 'name'
        expect(json['user']['name']).to eq user.name
      end

      it "returns email" do
        expect(json['user'].keys).to include 'email'
        expect(json['user']['email']).to eq user.email
      end

      it "returns links" do
        expect(json['user'].keys).to include 'links'
      end
    end

    context "with an invalid url parameter" do
      let(:json) { JSON.parse(response.body) }

      before do
        get :show, api_key: user.api_key, id: ''
      end

      it "returns a JSON body with an error message" do
        expect(response.body).to include '{"errors":"invalid id"}'
      end
    end
  end

end
