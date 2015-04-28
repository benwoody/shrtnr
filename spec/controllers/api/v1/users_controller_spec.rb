require 'spec_helper'

describe Api::V1::UsersController, type: :controller do

  let(:user) { create(:user) }

  describe "#show" do
    context  "with invalid api_key" do
      it "returns a 401" do
        get :show, api_key: 'blank'
        expect(response.code).to eq '401'
      end
    end

    context "with a valid api_key" do
      let(:json) { JSON.parse(response.body) }

      before do
        get :show, api_key: user.api_key
      end

      it "returns a JSON body with a user key" do
        expect(json['user']).not_to be_empty
      end
    end

  end

end
