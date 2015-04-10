require 'spec_helper'

describe SessionsController do

  let(:user) { create(:user) }

  describe "#direct" do
    it "redirects to dashboard_path if signed_in?" do
      sign_in(user)
      get :direct
      expect(response).to redirect_to(dashboard_path)
    end

    it "redirects to home_path if not signed_in?" do
      get :direct
      expect(response).to redirect_to(home_path)
    end

  end

  describe "#new" do
    it "is successful" do
      get :new
      expect(response).to be_success
    end

  end
end
