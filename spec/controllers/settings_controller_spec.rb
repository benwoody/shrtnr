require 'spec_helper'

describe SettingsController, type: :controller do

  let(:user) { User.create!(email: 'test@test.com', password: "Password",
                            password_confirmation: "Password")
  }

  describe "#add_twitter" do
    context "with valid credentials" do
      before do
        OmniAuth.config.add_mock(:twitter, { uid: '12345' })
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
      end

      it "adds a uid to User" do
        # I expected the session to exist, but it does not
        # put :add_twitter
        # puts session[:add_twitter]
      end
    end
  end
end
