require "spec_helper"

describe SettingsMailer, :type => :mailer do
  let(:user) { create(:user) }

  describe "#settings_change_email" do
    let(:mail) { SettingsMailer.settings_change_email(user, user) }

    it "renders the correct headers" do
      expect(mail.from).to include "admin@shrtnr.com"
      expect(mail.to).to include user.email
      expect(mail.subject).to include "Your settings have changed"
    end

    it "renders an html layout" do
      expect(mail.html_part.body).to include "You have successfully updated your settings"
    end

    it "renders a text layout" do
      expect(mail.text_part.body).to include "You have successfully updated your settings"
    end
  end
end
