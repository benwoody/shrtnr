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

  context "with not matching password" do

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

  context "with invalid email" do

    before do
      visit "/users/new"
      fill_in "Email", with: "nonsense"
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "Password"
      click_button "Submit"
    end

    it "tells the user they have signed up" do
      expect(page).to have_content "You have signed up"
    end
  end

  context "sign in with Twitter" do

    before do
      visit "/users/new"
      click_link "Sign in with Twitter"
    end

    it "leads to Twitter authentication page" do
      expect(current_path).to eq "/auth/twitter"
    end
  end

  context "with all missing fields" do

    before do
      visit "/users/new"
      click_button "Submit"
    end

    it "tells user they can't leave password blank" do
      expect(page).to have_content "Password can't be blank"
    end
  end

  context "Email field blank" do

    before do
      visit "/users/new"
      fill_in "Password", with: "fake"
      fill_in "Password confirmation", with: "fake"
      click_button "Submit"
    end

    it "tells the user they have signed up" do
      expect(page).to have_content "You have signed up"
    end
  end

  context "Password field blank" do

    before do
      visit "/users/new"
      fill_in "Email", with: "fake"
      click_button "Submit"
    end  

    it "tells user they can't leave password blank" do
      expect(page).to have_content "Password can't be blank"
    end
  end

  context "sign up with email already in use" do

    before do
      visit "/users/new"
      fill_in "Email", with: "nonsense"
      fill_in "Password", with: "fake"
      fill_in "Password confirmation", with: "fake"
      click_button "Submit"
      visit "/users/new"
      fill_in "Email", with: "nonsense"
      fill_in "Password", with: "fake"
      fill_in "Password confirmation", with: "fake"
      click_button "Submit"
    end

    it "tells the user the email has been taken" do
      expect(page).to have_content "Email has already been taken"
    end
  end
end