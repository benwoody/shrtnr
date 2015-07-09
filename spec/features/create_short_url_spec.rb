require 'spec_helper'

describe "creating a short url" do
  context "when not signed in" do
    before do
      visit "/home"
      fill_in "long_url", with:"http://google.com"
      click_button "Shorten It!"
    end

    it "shows user a link" do
      expect(page).to have_content "links to"
    end

    it "contains the original link" do
      expect(page).to have_content "http://google.com"
    end
  end

  context "when signed in" do
    let(:user) { create(:user) }

    before do
      login_as user
      visit "/dashboard"
      fill_in "long_url", with:"http://google.com"
      click_button "Shorten It!"
    end

    it "shows user a link" do
      expect(page).to have_content "links to"
    end

    it "contains the original link" do
      expect(page).to have_content "http://google.com"
    end

    it "shows the the link on dashboard" do
      visit "/dashboard"
      expect(page).to have_content "http://google.com"
    end

  end
end
