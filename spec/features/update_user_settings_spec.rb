require 'spec_helper'

describe "updating user settings" do
  context "when not signed in" do
    before do
      visit "/home"
      visit "/settings"
    end

    it "prompt user to sign in" do
      expect(page).to have_content "Please sign in"
    end

    it "redirect to sign in page" do 
      expect(current_path).to eq "/login"
    end  
  end

  context "when signed in" do
    let(:user) { create(:user) }

    before do
      login_as user
      visit "/settings"
      fill_in "settings_name", with:"me"
      fill_in "settings_email", with:"a@a.com"
      click_button "Update"
    end

    it "informs user that settings has been updated" do
      expect(page).to have_content "Successfully updated settings"
    end

    it "stays on settings page" do 
      expect(current_path).to eq "/settings"
    end

  end

  context "when updated settings" do
    let(:user) { create(:user) }

    before do
      login_as user
      visit "/settings"
      fill_in "settings_name", with:"me"
      fill_in "settings_email", with:"a@a.com"
      click_button "Update"
      visit "/login"
      fill_in "email", with:"a@a.com"
      fill_in "password", with:user.password
      click_button "Login"
    end

    it "logged in successfully" do
      expect(page).to have_content "You have been logged in"
    end 
  end



end


