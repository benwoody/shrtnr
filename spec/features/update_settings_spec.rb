require 'spec_helper'

describe 'update settings' do 
  let(:user) { create(:user) }

  before do
    login_as user
    visit '/settings'
    fill_in 'settings[name]', with: "Jack Horkheimer"
    fill_in "settings[email]", with: "jack@bogus.com"
    click_button "Update"
  end

  it "should tell the user that settings were updated" do
    expect(page).to have_content "Successfully updated settings"
  end
  
end