require 'spec_helper'
  describe "Updating Settings" do
    context "should log in" do
    let(:user) {create(:user)}
    before do
     login_as user
     visit "/settings"
     fill_in 'name', with: "Kim Dotcom"
     click_button "Update"
    end
    it "tells the user they have updated settings" do
      expect(page).to have_content "Successfully updated settings"
    end
  end
end
