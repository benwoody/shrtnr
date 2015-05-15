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

  context "without proper email params" do
    before do
      visit "users/new"
      fill_in "Email", with: ""
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "Password"
      click_button "Submit"
    end

    it "tells the user they have made a mistake" do
      expect(page).to have_content "You must enter an email address into the respective field"
    end
  end

  context "with an already existing email address" do
    before do
      visit "users/new"
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "Password"
      click_button "Submit"
    end

    it "tells the user they have made a mistake" do
      visit "users/new"
      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "Password"
      click_button "Submit"

      expect(page).to have_content "Email address is already registered"
    end
  end
end
