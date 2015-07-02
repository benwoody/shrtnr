require 'spec_helper'
  describe "Updating Settings" do
    context "should log in" do
    before do
    visit "/login"
    fill_in "Email", with: "k@kim.com"
    fill_in "Password", with: "123456"
    click_button "Login"
    end
    context "should visit the user's settings page and edit the form" do
    after do
      visit "/settings"
      fill_in 'name', with: "Kim Dotcom"
      click_button "Update"
    end
    it "tells the user they have signed up" do
      expect(page).to have_content "Successfully updated settings"
    end
  end
end
end
