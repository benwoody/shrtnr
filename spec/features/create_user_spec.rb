require 'spec_helper'

describe "creating a user" do
  context "with valid params" do

    before do
      visit "/users/new"
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "Password"
      click_button "Submit"
    end

    it "tells the user they have signed up" do
      expect(page).to have_content "You have signed up"
    end

    it "sends them to the dashboard" do
      expect(current_path).to eq "/dashboard"
    end

  end

  context "with invalid params" do

    before do
      visit "/users/new"
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "NOPE"
      click_button "Submit"
    end

    it "tells the user they made a mistake" do
      expect(page).to have_content "Password confirmation doesn't match Password"
    end

  end

end

describe "logging in as an existing user" do

  context "with a valid user" do

    before do
      visit "/users/new"
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "Password"
      click_button "Submit"

      visit "/login"
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "Password"
      click_button "Login"
    end

    it "tells the user they have logged in" do
      expect(page).to have_content "You have been logged in."
    end

    it "sends them to the dashboard" do
      expect(current_path).to eq "/dashboard"
    end

  end

  context "with an invalid user" do

    before do
      visit "/users/new"
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "Password"
      click_button "Submit"

      visit "/login"
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "NOPE"
      click_button "Login"
    end

    it "tells the user their login failed" do
      expect(page).to have_content "Your username or password are incorrect. Please try again."
    end

    it "should still be on the login page" do
      expect(current_path).to eq "/login"
    end

  end

end
