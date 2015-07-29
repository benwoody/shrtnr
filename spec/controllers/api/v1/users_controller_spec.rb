require 'spec_helper'

describe Api::V1::UsersController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let(:link) { create(:link, user_id: user.id) }

  describe "#show" do
    context "with a valid user id" do
      let(:json) { JSON.parse(response.body) }

      it "returns the user" do
        get :show, id: user.id, api_key: user.api_key
        expect(json["user"].keys).to include "name", "email", "links"
      end
    end

    context "with an invalid user id" do
      let(:json) { JSON.parse(response.body) }

      it "returns an error message" do
        get :show, id: "notvalid", api_key: user.api_key
        expect(json.keys).to include "error"
      end

    end
  end
end
