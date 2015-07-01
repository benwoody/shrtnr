require 'spec_helper'

describe SettingsController, type: :controller do
  render_views

  let(:user) { create(:user) }

  before do
    allow(self.controller).to receive(:current_user).and_return(user)
    get :index
  end

  it 'is successfull' do
    expect(response).to be_success
  end
  
  it 'renders the index view' do
    expect(response).to render_template("index")
  end
end
