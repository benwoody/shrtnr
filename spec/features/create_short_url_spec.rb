require 'spec_helper'

describe "creating a short url" do
  context "when not signed in" do
  	before do
    	visit "/home"
      fill_in "long_url", with: "http://foo.com"
      click_button "Shorten It!"
  	end

    it "shortening an url displays the short link" do
      expect(page).to have_content "links to http://foo.com"
    end
  end

  context "when signed in" do
    let(:user) { create(:user) }

    before do
      login_as user

      visit "/home"
      fill_in "long_url", with: "http://foo.com"
      click_button "Shorten It!"
    end

    it "shortening an url displays the short link" do
      expect(page).to have_content "links to http://foo.com"
    end

    it "add says that the URL was added" do
      expect(page).to have_content "URL added"
    end
  end
end
