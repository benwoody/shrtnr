require 'spec_helper'

describe SettingsController do

  let(:user) { create(:user) }

  describe "#index" do
    context "when not signed in" do
      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to(login_url)
      end
    end

    context "when signed in" do
      before do
        sign_in user
        get :index
      end

      it "is successful" do
        expect(response).to be_success
      end

      it "assigns the correct user" do
        expect(assigns(:settings)).to eq user
      end
    end
  end

  describe "#update" do
    before do
      sign_in user
    end

    it "updates user settings" do
      attrs = { name: "New Name", email: "new@email.com" }
      put :update, settings: attrs
      expect(assigns(:settings).name).to eq attrs[:name]
      expect(assigns(:settings).email).to eq attrs[:email]
    end

    it "sends a notification email" do
      attrs = { name: "Ralph Tirebiter", email: "ralph@tirebiter.com" }
      expect {
        put :update, settings: attrs
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it "sent notification email contains old and new name values" do
      attrs = { name: "Ralph Tirebiter" }
      put :update, settings: attrs
      expect(ActionMailer::Base.deliveries.last.html_part.body).to include("Old name:")
      expect(ActionMailer::Base.deliveries.last.html_part.body).to include("New name: Ralph Tirebiter")
    end

    it "sent notification email contains old and new email values" do
      attrs = { email: "ralph@tirebiter.com" }
      put :update, settings: attrs
      expect(ActionMailer::Base.deliveries.last.html_part.body).to include("Old email:")
      expect(ActionMailer::Base.deliveries.last.html_part.body).to include("New email: ralph@tirebiter.com")
    end
  end
end
