 require 'spec_helper'

describe SettingsController, type: :controller do
   
  let(:user) { FactoryGirl.create(:user) }
=begin
  let(:settings) do
    {
      :name => "name",
      :email => "e@m.com"
    }
  end
    

  let(:settings_params) { settings }
=end

  before(:each) do
    @settings = { :name => "name", :email => "e@m.com"},
    @settings_params = { :name => "name", :email => "email" }
  end

  describe "#index" do
    it "settings for signed_in user?" do
      get :index
      expect(response).to be_success
    end
  end

  describe "#update" do
    it "is successful" do
      pending "Need to figure this out"
    
      post :update, user: @settings_params
      expect(response).to redirect_to(settings_url)
    end

  end
  
end

