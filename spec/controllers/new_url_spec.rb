require 'spec_helper'
  describe "creating a short url" do
    context "should visit the home page and create a new url" do
    before do
      visit "/home"
      fill_in "long_url", with: "https://www.google.com/maps/place/Seattle,+WA,+USA/@47.614848,-122.3359058,11z/data=!4m2!3m1!1s0x5490102c93e83355:0x102565466944d59a"
      click_button "Shorten It!"
    end
    it "tells the user the short url" do
      expect(page).to have_content "links to"
    end
  end
end
