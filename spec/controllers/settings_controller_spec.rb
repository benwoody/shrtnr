require 'spec_helper'

describe SettingsController, type: :controller do
  let(:user) { create(:user) }
  let(:attributes) { attributes_for :user }

  
  before do
    allow(self.controller).to receive(:current_user).and_return(user)
  end


  describe "#index" do
    it "is successful" do
      get :index
      expect(response).to be_success
    end
  end



  # describe "#home" do
  #   it "is successful" do
  #     get :home
  #     expect(response).to be_success
  #   end
  # end

end
