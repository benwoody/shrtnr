require 'spec_helper'
  describe "creating a user" do
    context "should visit the new user's page and fill in the form" do
    before do
      visit "/users/new"
      fill_in "Email", with: "k@kim.com"
      fill_in "Password", with: "123456"
      fill_in "Password confirmation", with: "123456"
      click_button "Submit"
    end
    it "tells the user they have signed up" do
      expect(page).to have_content "You have signed up"
    end
  end
end
