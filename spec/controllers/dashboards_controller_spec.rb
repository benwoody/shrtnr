require 'spec_helper'

describe DashboardsController, type: :controller do
  let(:user) { create(:user) }
  let(:links) { [create(:link), create(:link)] }

  describe '#index' do
    it 'is successful' do
      sign_in user
      get :index
      expect(response).to be_success
    end
  end

  describe '#home' do
    it 'is successful' do
      get :home
      expect(response).to be_success
    end
  end
end
