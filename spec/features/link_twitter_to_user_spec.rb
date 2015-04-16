require 'spec_helper'

describe "link twitter to existing user account" do
  context "has linked to twitter before" do

    before do
      User.create(email: "testie@mctesterson.com", 
                  password: "test1234", 
                  password_confirmation: "test1234", 
                  uid: "1111111111")

      visit "/login"
      fill_in "Email", with: "testie@mctesterson.com"
      fill_in "Password", with: "test1234"
      click_button "Login"
      visit '/settings'
    end

    it 'provide an option to link account to twitter' do
      expect(page).not_to have_link('Link Account to Twitter')
    end
  end

  context "has never linked account to twitter" do

    before do
      visit "/users/new"
      fill_in "Email", with: "jon12@test.com"
      fill_in "Password", with: "Password"
      fill_in "Password confirmation", with: "Password"
      click_button "Submit"
      visit '/settings'
    end

    it 'provide an option to link account to twitter' do
      expect(page).to have_link('Link Account to Twitter')
    end

    it "adds twitter to user account" do
      click_link "Link Account to Twitter"
      expect(page).to have_content("You may now sign in with your twitter account.")
      expect(User.find_by(email: 'jon12@test.com').uid).to eq('1234')
    end
  end
end
