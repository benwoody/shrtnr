require 'spec_helper'
  describe "Updating Settings" do
    context "should log in" do
    before do
      visit "/users/new"
      fill_in "Email", with: "k@kim.com"
      fill_in "Password", with: "123"
      fill_in "Password confirmation", with: "123"
      click_button "Submit"
   end

  it "has a twitter button" do
    visit "/settings"
    expect(page).to have_content "Twitter"
  end
  
  it "clicks the twitter button" do
    visit "/settings"
    click_link "Twitter"
    expect(page).to have_content "Authorize UWShortener to use your account?"
  end
 end
end
