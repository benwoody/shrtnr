require 'spec_helper'

describe 'regenerating api_key' do
  
  let(:user) { create(:user) }

  before do
    login_as user
    visit settings_path
  end

  it 'should have a button for regenerating the API key' do
    expect(page).to have_button 'Regenerate key'
  end

  it 'should warn the user about invalidating the API key' do
    #Can't figure out how to test this.
  end

  it 'should change the API key' do
    old_api = page.find("pre").text
    click_button("Regenerate key")
    expect(page.find("pre").text).not_to eq(old_api)
  end

end
