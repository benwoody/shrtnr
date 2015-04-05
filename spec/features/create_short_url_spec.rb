require 'spec_helper'

describe "creating a short url" do
  context "when not signed in" do
    before do
      visit "/home"
      fill_in "link[long_url]", :with => "http://www.msn.com"
      click_button "Shorten It"
    end
    
    it "should create a record for the new URL in the database" do
      expect(Link.last.long_url).to eq("http://www.msn.com")
      expect(Link.last.short_url).not_to be_nil 
    end 
    
    it "should deliver success message for a new URL to user" do
      expect(page).to have_content "URL added"
    end
    
    it "should go to the link page for the new link" do
      url = URI.parse(current_url).to_s
      expect(url).to include("/links/#{Link.last.short_url}")
    end
    
end

  context "when signed in" do
    let(:user) { create(:user) }

    before do
      login_as user
      visit "/home"
      fill_in "link[long_url]", :with => "http://www.msn.com"
      click_button "Shorten It"
    end
    
    it "should create a record for the new URL in the database associated to the user" do
      expect(Link.last.long_url).to eq("http://www.msn.com")
      expect(Link.last.short_url).not_to be_nil
      expect(Link.last.user_id).not_to be_nil
      expect(Link.last.user_id).to eq(user.id) 
    end 
    
    it "should deliver success message for a new URL to user" do
      expect(page).to have_content "URL added"
    end
    
    it "should go to the link page for the new link" do
      url = URI.parse(current_url).to_s
      expect(url).to include("/links/#{Link.last.short_url}")
    end
    
    
    
    
  end
end
