require 'spec_helper'

describe "link a twitter account" do 

	context "user already is linked" do
		
		before do
			User.create email: "abcd@abcd.com", password: "helloworld", uid: "abcd"
			visit "/login"
			fill_in "Email", with: "abcd@abcd.com"
			fill_in "Password", with: "abcd"
			click_button "Login"
		end

		after do
			User.last.destroy
		end

		it "should not have button to link Twitter account" do
			visit "/settings"
			expect(page).not_to have_link("Link up your Twitter!")
		end
	end

	context "user not linked to Twitter yet" do

		before do
			visit "/users/new"
			fill_in "Email", with: "abcd@abcd.com"
			fill_in "Password", with: "abcd"
			fill_in "Password confirmation", with: "abcd"
			click_button "Submit"
		end

		it "should have button to link Twitter account" do
			visit "/settings"
			expect(page).to have_link("Link up your Twitter!")
		end

		it "should redirect to Twitter when button is pushed" do
			visit "/settings"
			click_link "Link up your Twitter!"
			expect(page).to have_content("Twitter account linked!")
		end
	end
	
end