require 'spec_helper'

describe "creating a short url" do
  let(:long_url) { "http://www.wsj.com" }

  context "when not signed in" do

    before do
      visit "/"
      fill_in "long_url", with: long_url
      click_button "Shorten It!"
    end

    it "creates a short url" do
      expect(current_path).to start_with "/links"
    end
  end

  context "when signed in" do
    let(:user) { create(:user) }

    scenario "creating a new short url" do
      login_as user
      visit "/dashboard"
      fill_in "long_url", with: long_url
      click_button "Shorten It!"

      expect(current_path).to start_with "/links"
      expect(page).to have_content "URL added"

      visit "/dashboard"

      expect(page).to have_content long_url
    end
  end
end
