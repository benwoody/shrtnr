require 'spec_helper'

describe "creating a short url" do

  context "when not signed in" do

    before do
      visit "/home"
      #puts page.body
      fill_in "long_url", with: "http://www.google.com"
      click_button "Shorten It!"
    end

    it "gives the user the shortened link" do
      expect(page).to have_content "links to"
    end
    it "takes the user to the links/link page" do
      expect(current_path).to_not eq "/home"

    end
  end

  context "when signed in" do
    let(:user) { create(:user) }

    before do
      login_as user
      visit "/home"
      #puts page.body
      fill_in "long_url", with: "http://www.google.com"
      click_button "Shorten It!"
    end

    it "tells the user the URL has been added" do
      expect(page).to have_content "URL added"
    end
    it "takes the user to the links/link page" do
      expect(current_path).to_not eq "/home"

    end
  end
end
