require 'spec_helper'

describe "creating a short url" do
  context "when not signed in" do
    let(:url) { "http://www.microsoft.com" }

    before do
      visit "/home"
      fill_in "link[long_url]", with: url
      click_button "Shorten It!"
    end

    it "should have a short link" do
      expect(page).to have_content /shrt.nr\/[a-z0-9]{6}/
    end

    it "should tell where the short link points" do
       expect(page).to have_content url
    end

  end

  context "when signed in" do
    let(:user) { create(:user) }
    let(:url) { "http://www.microsoft.com" }
    
    before do
      login_as user
      fill_in "link[long_url]", with: url
      click_button "Shorten It!"
    end

    it "should have a short link" do
      expect(page).to have_content /shrt.nr\/[a-z0-9]{6}/
    end

    it "should tell where the short link points" do
       expect(page).to have_content url
    end
  end
end
