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

    it "should be linkable to Twitter" do
      visit "/settings"

      expect(page).to have_content "Link To Twitter Account"
    end
    
  end
end
