require 'spec_helper'

describe "updating settings" do
  context "when not signed in" do

    before do
      visit "/settings"
    end

    it "redirects user to the login page" do
      expect(current_path).to eq "/login"
    end
  end

  context "when signed in" do
    let(:user) { create(:user) }

    before do
      login_as user
      visit "/settings"
    end

    context "when valid params" do
      before do
        fill_in "Name", with: "Anna Banana"
        fill_in "Email", with: user.email
        click_button "Update"
      end

      it "should be successful" do
        expect(page).to have_content "Successfully updated settings"
      end
    end

    context "when duplicate email " do
      let(:existing_user) { create(:user) }

      before do
        fill_in "Name", with: "Anna Banana"
        fill_in "Email", with: existing_user.email
        click_button "Update"
      end

      it "should fail" do
        expect(page).to have_content "Failed to update settings"
      end
    end
  end
end
