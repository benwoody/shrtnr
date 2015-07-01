require 'spec_helper'

describe "updating settings" do
  context "when signed in" do
    let(:user) { create(:user) }

    before do
      login_as user
      visit "/settings"
      #puts page.body
      fill_in "Name", with: "Test"
      fill_in "Email", with: "test@test.com"
      click_button "Update"
    end

    it "tells the user they have updated their settings" do
      expect(page).to have_content "Successfully updated settings"
    end
    it "sends the user to the settings page" do
      expect(current_path).to eq "/settings"
    end
  end
  
end