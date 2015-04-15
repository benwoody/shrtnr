require 'spec_helper'

describe "Twitter association" do

  context "can link to Twitter" do

    before do
      visit "/users/new"
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "Password"
      click_button "Submit"
    end

    it "should be able to add a Twitter id" do
      visit "/settings"

      fill_in "Twitter ID", with: "1234"
      click_button "Update"

      expect(page).to have_content "Successfully updated settings"
    end

    it "should have the Twitter user id" do
      #expect(page).to have_selector("input", exact: "1234")

      #expect(page).to have_field "settings[uid]"
      #expect(page).to have_field "Twitter ID"
      #expect(page).to have_field "settings_uid"
      expect(page).to have_selector("input#settings_uid")
    end

#    it "should be able to remove a Twitter id" do
#      visit "/settings" #reset the page
#
#      fill_in "Twitter ID", with: ""
#      click_button "Update"
#
#      expect(page).to have_content "Successfully updated settings"
#    end

#    it "should have the Twitter user id" do
#      expect(page).to have_selector("input", exact: "")
#    end
    
  end
end
