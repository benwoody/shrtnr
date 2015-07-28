require 'spec_helper'

describe SettingsController do

  let(:user) { create(:user) }

  describe "#index" do
    context "when not signed in" do
      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to(login_url)
      end
    end

    context "when signed in" do
      before do
        sign_in user
        get :index
      end

      it "is successful" do
        expect(response).to be_success
      end

      it "assigns the correct user" do
        expect(assigns(:settings)).to eq user
      end
    end
  end

  describe "#update" do
    before do
      sign_in user
    end

    it "updates user settings" do
      attrs = { name: "New Name", email: "new@email.com" }
      put :update, settings: attrs
      expect(assigns(:settings).name).to eq attrs[:name]
      expect(assigns(:settings).email).to eq attrs[:email]
    end
  end

  describe "#update_api_key" do
    before do
      sign_in user
    end

    it "generates a new api key" do
      # new_key = user.generate_api_key
      attrs = { api_key: user.generate_api_key }
      # expect(user.api_key).to eq new_key  
      put :update_api_key, settings: attrs
      expect(assigns(:settings).api_key).to eq attrs[:api_key]
    end
  end

end
