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

    it "should have the link in the database" do
      entry = Link.find_by long_url: url
      expect(entry).to be_truthy
      @short = entry.short_url
    end 

    it "should be linkable to the dashboard" do
      page.find_link("DASHBOARD").click
    end

    it "should have the short link" do
      expect(page).to have_content @short
    end 

    it "should have the long link" do
      expect(page).to have_content url
    end 

  end 

end 
