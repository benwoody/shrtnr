require 'spec_helper'

describe SettingsController, type: :controller do

  let(:existing_user) { create(:user) }
  let(:user) { create(:user) }
  let(:attrs) { user.attributes }

  before do
    allow(self.controller).to receive(:current_user).and_return(user)
  end

  describe "#index" do
    it "is successful" do
      get :index
      expect(response).to be_success
    end
  end

  describe "#update" do
    it "is successful" do
      post :update, settings: attrs
      expect(response).to redirect_to settings_url
      expect(flash[:notice]).to eq "Successfully updated settings"
    end

    it "failure due to duplicate email" do
      attrs[:email] = existing_user.email
      post :update, settings: attrs
      expect(response).to redirect_to settings_url
      expect(flash[:alert]).to eq "Failed to update settings"
    end
  end
end
