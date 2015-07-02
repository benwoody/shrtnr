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

  

end
