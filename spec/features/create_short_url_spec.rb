require 'spec_helper'

describe "creating a short url" do
  context "when not signed in" do
    #add a spec here
    before do
      visit "/home"
      fill_in "long_url", with: "http://www.psrc.org"
      click_button "Shorten It!"
    end

    it "tells the user the short url" do
      #replace this with a regex check
      expect(page).to have_content "shrt.nr"
    end
  end

  context "when signed in" do
    let(:user) { create(:user) }

    before do
      login_as user
      visit "/dashboard"
      fill_in "long_url", with: "http://www.psrc.org"
      click_button "Shorten It!"
    end

    it "lists the long url" do
      expect(page).to have_content "http://www.psrc.org"
    end

  end
end
