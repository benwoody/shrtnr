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

  context "with non matching passwords" do

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

  context "with an already existing email address" do
    before do
      2.times do
        visit "/users/new"
        fill_in "Email", with: "test@test.com"
        fill_in "Password", with: "Password"
        fill_in "Password confirmation", with: "Password"
        click_button "Submit"
      end
    end

    it "tells them the email has already been taken" do
      expect(page).to have_content "Email has already been taken"
    end      
  end

  context "clicking SIGN UP from SIGN IN" do
    before do
      visit "/login"
    end

    it "takes the user to the sign up page" do
      click_link "SIGN UP"
      expect(current_path).to eq "/users/new"
    end
  end

  context "clicking SIGN IN from SIGN UP" do
    before do
      visit "/users/new"
    end

    it "takes the user to the sign in page" do
      click_link "SIGN IN"
      expect(current_path).to eq "/login"
    end
  end

end
