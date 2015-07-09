require 'spec_helper'

describe SettingsController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "#index" do
    it "is successfull" do
      get :index
      expect(response).to be_success
    end
  end

  describe "#update" do
    it "updates settings" do
      put :update, settings: {:name=> "me", :email=> "test@test.com"}
      expect(user[:name]).to eq("me")
      expect(user[:email]).to eq("test@test.com")
    end

  end

end
