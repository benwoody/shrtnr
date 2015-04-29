require 'spec_helper'

describe 'api_key regeneration' do
  let(:user) { create(:user) }

  before do
    login_as user
    visit settings_path
  end

  it 'should have a api_key regeneration button' do
    expect(page).to have_button 'API Key Regeneration'
  end

  # describe 'should create new api key after accepting warning', js: true do
  #  it 'should warn user when api key is regenerted' do
  #    warning =  dismiss_confirm do
  #      click_button('API Key Regeneration')
  #    end
  #    expect(warning).to include('Is that OK?')
  #  end
  # end
end
