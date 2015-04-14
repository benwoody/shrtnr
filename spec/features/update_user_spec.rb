require 'spec_helper'

describe "updating a user" do

  context "when a twitter account isn't linked yet" do
    before do
      visit "/users/new"
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "Password"
      click_button "Submit"
      visit "/settings"
    end

    it "there should be a 'add twitter' link" do
      expect(page).to have_link("Add Twitter")
    end

    it "links twitter to the account" do
      click_link "Add Twitter"
      expect(page).to have_content("You have added Twitter credentials to your account")
    end
  end

  context "when a twitter account is already linked" do
    before do
      User.create email: "test@test.com", password: "Password", password_confirmation: "Password", uid: "twitter_handle"
      visit "/login"
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "Password"
      click_button "Login"
      visit "/settings"
    end

    it "there should be no 'add twitter' link" do
      expect(page).not_to have_link("Add Twitter")
    end
  end

  context "when a twitter account is already linked" do
    before do
      OmniAuth.config.add_mock(:twitter, { uid: '12345' })
      User.create email: "some_other_user@test.com", password: "Password", password_confirmation: "Password", uid: "12345"

      visit "/users/new"
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "Password"
      click_button "Submit"
      visit "/settings"
    end

    it "clicking 'add twitter' shows an error message" do
      click_link "Add Twitter"
      expect(page).to have_content("You've already created a shrtnr account using this Twitter id")
    end
  end


end
