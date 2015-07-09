require 'spec_helper'

describe SettingsController, type: :controller do

  let(:user) { create(:user) }

  describe "#index" do
   context "no login" do
     it "goes to log in page" do
       get :index
       expect(response).to redirect_to(login_url)
    end
   end
  end

   context "signin" do
    before do
      sign_in user
      get :index
   end
 
    it "is successful" do
      expect(response).to be_success
    end
    
    it "updates settings" do
      put :update, settings: { :name => "Kim Dotcom", :email => "k@kim.com" }
      expect(assigns(:settings).name).to eq "Kim Dotcom"
      expect(assigns(:settings).email).to eq "k@kim.com"
    end
  end
end
