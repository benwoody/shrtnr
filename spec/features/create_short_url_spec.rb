require 'spec_helper'

describe "creating a short url" do
  context "when not signed in" do
    let(:user) { create(:user) }
    let(:url) { "http://www.lifehacker.com" }

    before do
      visit "/home"
      fill_in "link_long_url", with: url
      click_button 'Shorten It!'
    end

    it "tells the user what the shortened link path is" do
      expect(page).to have_content /shrt.nr\/[a-zA-Z0-9]{6}/
    end

    it "tells the user what the shortened link points to" do
      expect(page).to have_content url
    end

    it "sends them to the unique link path" do
      expect(current_path).to match /\/links\/[a-zA-Z0-9]{6}/
    end
  end

  context "when signed in" do
    let(:user) { create(:user) }
    let(:url) { "http://www.lifehacker.com" }

    before do
      login_as user
      fill_in "link_long_url", with: url
      click_button 'Shorten It!'
    end

    it "tells the user what the shortened link path is" do
      expect(page).to have_content /shrt.nr\/[a-zA-Z0-9]{6}/
    end

    it "tells the user what the shortened link points to" do
      expect(page).to have_content url
    end

  end
end
