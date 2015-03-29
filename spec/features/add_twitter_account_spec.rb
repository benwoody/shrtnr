require 'spec_helper'

describe "connecting a twitter account" do

  context "user not linked to twitter" do

    before do
      visit "/users/new"
      fill_in "Email", with: "testabc@test.com"
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "Password"
      click_button "Submit"
    end

    it "settings should have a button to link to twitter" do
      visit "/settings"
      expect(page).to have_button("Link Twitter Account")
    end

    it "should redirect the user to twitter and link when button pushed" do
      visit "/settings"
      click_button "Link Twitter Account"
      expect(page).to have_content("Your Twitter account has been linked.")
      expect(page).to_not have_button("Link Twitter Account")
      expect(User.last.uid).not_to be_nil
    end

  end

  context "user already linked to twitter" do

    before do
      User.create email: "foo@foo.com", password: "12345", password_confirmation: "12345", uid: "123"
      visit "/login"
      fill_in "Email", with: "foo@foo.com"
      fill_in "Password", with: "12345"
      click_button "Login"
    end

    after do
      User.last.destroy
    end

    it "settings should not have a button to link to twitter" do
      visit "/settings"
      expect(page).not_to have_button("Link Twitter Account")
    end

  end

end
