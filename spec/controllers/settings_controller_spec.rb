 require 'spec_helper'

describe SettingsController, type: :controller do
   
  let(:user) { FactoryGirl.create(:user) }

  let(:settings_params) do
    {
      :name => "name",
      :email => "e@m.com"
    }
  end
    
  describe "#index" do
    it "settings for signed_in user?" do
      get :index
      expect(response).to be_success
    end
  end
  before do
    sign_in(user)
  end


  describe "#update" do
    it "is successful" do
      post :update, settings: settings_params
      expect(response).to redirect_to(settings_url)
    end

  end
  
end

