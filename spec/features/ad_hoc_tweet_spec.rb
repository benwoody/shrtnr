require 'spec_helper'

describe "add hoc tweeting" do
  context "when signed in" do
    
    let(:user) { create(:user) }

    before do
      login_as user
      visit "/"
      fill_in "link[long_url]", with: "http://www.github.com"
      click_button "Shorten It!"
    end
    
    
    it "has a tweet button for each link" do
      visit "/"
      expect(page).to have_link "Tweet Me!"
    end
  end
end