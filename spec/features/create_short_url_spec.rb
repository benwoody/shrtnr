require 'spec_helper'

describe "creating a short url" do
  let(:long_url) { "http://www.onlinemetals.com/makeinfo.cfm" }

  context "when not signed in" do
    before do
      visit "/"
      fill_in "long_url", with: long_url
      click_button "Shorten It!"
    end

    it "visits /links/shortened_URL" do
      expect(current_path).to match /\/links\/[0-9a-zA-Z ]{6}/
    end

    it "gives message 'URL added'" do
      expect(page).to have_content "URL added"
    end

    it "shows a shortened URL" do
      expect(page).to have_content /shrt.nr\/[0-9a-zA-Z ]{6}/
    end

    it "says 'links to'" do
      expect(page).to have_content "links to"
    end

    it "shows the original long URL" do
      expect(page).to have_content long_url
    end
  end

  context "when signed in" do
    let(:user) { create(:user) }

    before do
      login_as user
      visit "/"
      fill_in "long_url", with: long_url
      click_button "Shorten It!"
    end

    it "visits /links/shortened_URL" do
      expect(current_path).to match /\/links\/[0-9a-zA-Z ]{6}/
    end

    it "gives message 'URL added'" do
      expect(page).to have_content "URL added"
    end

    it "shows a shortened URL" do
      expect(page).to have_content /shrt.nr\/[0-9a-zA-Z ]{6}/
    end

    it "says 'links to'" do
      expect(page).to have_content "links to"
    end

    it "shows the original long URL" do
      expect(page).to have_content long_url
    end

    it "shows new link in list of links on dashboard page" do
      # TODO: this test is not complete, not sure yet how to store the shortened URL
      visit "/"
      expect(page).to have_content long_url
    end
  end
end
