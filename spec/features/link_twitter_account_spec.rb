require 'spec_helper'

describe "link twitter account" do
  let(:user) { create(:user) }

  context "when account is not linked" do

    before do
      login_as user
      visit "/settings"
    end

    it "fails if link button is not visible" do
      expect(page).to have_content "Link Twitter Account"
    end

    it "is successful" do
      OmniAuth.config.add_mock(:twitter, { uid: '12345' })

      click_link "Link Twitter Account"
      expect(current_path).to eq "/settings"
      expect(page).to have_content "Your account is now linked with your Twitter account."
      expect(page).to_not have_content "Link Twitter Account"
    end

    it "fails" do
      OmniAuth.config.mock_auth[:twitter] = :invalid_credentials

      click_link "Link Twitter Account"
      expect(current_path).to eq "/settings"
      expect(page).to have_content "Unable to link your account with your Twitter account."
      expect(page).to have_content "Link Twitter Account"
    end
  end

  context "when account is already linked" do

    it "fails if link button is visible" do
      user.uid = "12345"
      user.save!
      login_as user
      visit "/settings"

      expect(page).to_not have_content "Link Twitter Account"
    end
  end
end
