require 'spec_helper'

describe "creating a short url" do
  context "when not signed in" do
    before do
      visit "/home"
    end

    it "fails if url is not valid" do
      fill_in "link[long_url]", with: "nonsense"
      click_button "Shorten It!"
      expect(page).to have_content "Your URL was not valid"
    end

    it "fails if url is not given" do
      click_button "Shorten It!"
      expect(page).to have_content "Your URL was not valid"
    end

    it "creates a short_url if valid" do
      fill_in "link[long_url]", with: "http://google.com"
      click_button "Shorten It!"
      expect(page).to have_content "URL added"
    end
  end

  context "when signed in" do
    let(:user) { create(:user) }

    before do
      login_as user
      visit "/dashboard"
    end

    it "fails if url is not valid" do
      fill_in "link[long_url]", with: "nonsense"
      click_button "Shorten It!"
      expect(page).to have_content "Your URL was not valid"
    end

    it "fails if url is not given" do
      click_button "Shorten It!"
      expect(page).to have_content "Your URL was not valid"
    end

    it "creates a short_url if valid" do
      fill_in "link[long_url]", with: "http://google.com"
      click_button "Shorten It!"
      expect(page).to have_content "URL added"
    end

    it "adds link to dashboard" do
      fill_in "link[long_url]", with: "http://google.com"
      click_button "Shorten It!"
      visit "/dashboard"
      expect(page).to have_content "http://google.com"
    end

    it "doesn't add link to dashboard" do
      fill_in "link[long_url]", with: "nonsense"
      click_button "Shorten It!"
      expect(page).to have_content "Your URL was not valid"
    end
  end
end