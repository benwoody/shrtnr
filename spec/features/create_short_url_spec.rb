require 'spec_helper'

describe "creating a short url" do
  context "when not signed in" do

  	before do
  	  visit "/home"
  	  fill_in "link[long_url]", with: "https://www.google.com"
  	  click_button "Shorten It!"
  	end

  	it "tells user the shortened url" do
  	  expect(page).to have_content /shrt.nr\/[a-z0-9]{6}/
  	end

  	it "tells user the pertaining url associated with its shortened counterpart"
  	  expect)page).to have_content "https://www.google.com"
  	end

    it "has applicable links" do
      page.find_link("SIGN IN").click
      page.find_link("SIGN UP").click
    end

  context "when signed in" do
    let(:user) { create(:user) }

    before do
      login_as user
      visit "/home"
  	  fill_in "link[long_url]", with: "https://www.google.com"
  	  click_button "Shorten It!"
    end

  	it "tells user the shortened url" do
  	  expect(page).to have_content /shrt.nr\/[a-z0-9]{6}/
  	end

  	it "tells user the pertaining url associated with its shortened counterpart"
  	  expect)page).to have_content "https://www.google.com"
  	end

    it "has applicable links" do
      page.find_link("DASHBOARD").click
      page.find_link("SETTINGS").click
      page.find_link("LOGOUT").click
    end
  end
end
