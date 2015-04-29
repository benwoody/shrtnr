require 'spec_helper'

describe "resetting api_key" do

  let(:user) { create(:user) }
    
  before do
    login_as user
    visit settings_path
  end  
  
  it "should have a button to regen the key" do
    expect(page).to have_button "Regenerate Key"
  end
  
#  it "should warn the user when regen key button pushed" do
#    message = dismiss_confirm do
#      click_button("Regenerate Key")
#    end
#    expect(message).to include("Are you sure?") 
#  end
  
  it "should regen the key and refresh the page when the regen key button is pushed" do
    old_key = page.find("pre").text
    click_button("Regenerate Key")
    expect(page.find("pre").text).not_to eq(old_key)
  end
  
end
