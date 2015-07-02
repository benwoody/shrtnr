require 'spec_helper'

describe "creating a session" do
  context "before signing in" do
    it "has certain links" do
      visit "/home"
      expect(page).to have_link "SIGN IN"
      expect(page).to have_link "SIGN UP"
    end
  end

  context "after signing in" do
    let(:user) { create(:user) }

    before do
      login_as user
    end

    it "has certain links" do
      expect(page).to have_link "SETTINGS"
      expect(page).to have_link "LOGOUT"
    end

    it "shows users links on dashboard" do
      expect(page).to have_table "link_table"
    end

    it "can update user name in settings page" do
      visit "/settings"
      fill_in "settings[name]", with: "foobar"
      click_button "Update"
      expect(user.name).to be "foobar"
    end

    it "can update user email in settings page" do
      visit "/settings"
      fill_in "settings[email]", with: "foobar@foobar.com"
      click_button "Update"
      expect(user.email).to be "foobar@foobar.com"
    end
  end
end
