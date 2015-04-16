require 'spec_helper'

describe "connect a user" do
  context "with valid params" do

    before do
      visit "/users/new"
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "Password"
      click_button "Submit"

      visit "/settings"
    end

    it "tells the user they have signed up" do
      click_link "Connect My Account with Twitter"

      expect(page).to have_content "You have associated your Twitter account"
    end

  end

end
