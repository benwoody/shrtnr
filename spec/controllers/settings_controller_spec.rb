require 'spec_helper'

describe SettingsController, type: :controller do
  let(:user) { create(:user) }
  let(:attributes) { attributes_for :user }

  
  before do
    sign_in(user)
  end


  describe "#index" do
    it "is successful" do
      get :index
      expect(response).to be_success
    end
  end

  

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
end
