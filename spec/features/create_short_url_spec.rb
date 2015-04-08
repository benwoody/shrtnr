require 'spec_helper'

describe "creating a short url" do
  context "when not signed in" do

    before do
      visit "/home"
      fill_in "Long url", with: "http://www.systemsconcept.org"
      click_button "Shorten It!"
    end

   it "displays the shortened link" do
      expect(page).to have_content " Long url"
    end 

    before do
      visit "/home"
      fill_in "Long url", with: ""
      click_button "Shorten It!"
    end
    
     it "displays error alert" do
      expect(page).to have_content " not valid "
    end 

  end





  context "when signed in" do
    let(:user) { create(:user) }

    before do
      login_as user
    end
  end
end
