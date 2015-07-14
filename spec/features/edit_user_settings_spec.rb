require 'spec_helper'

describe "editing user settings" do
  context "no logged in user" do
    it "should redirect to login page" do
      visit "/settings/"
      expect(page).to have_content "Please sign in"
      expect(current_path).to eq "/login"
    end
  end

  context "logged in user" do
    let(:user) { create(:user) }
    before do
      login_as user
      visit "/settings"
    end

    it "should direct user to settings page after updating" do
      click_button "Update"
      expect(current_path).to eq "/settings"
    end

    it "should let user change their name" do
      fill_in "settings_name", with: "Jack Handy"
      click_button "Update"
      expect(page).to have_content "Successfully updated settings"
      expect(page).to have_content "Jack Handy"
    end

    it "should let user change their email" do
      fill_in "settings_email", with: "jack@handy.com"
      click_button "Update"
      expect(page).to have_content "Successfully updated settings"
      expect(page).to have_content "jack@handy.com"
    end

    it "should not accept invalid email address"
    # app not currently validating email addresses

    it "should not accept null email address" do
      fill_in "settings_email", with: "jack@handy.com"
      click_button "Update"
      expect(page).to have_content "Failed to update settings"
    end
  end

end
