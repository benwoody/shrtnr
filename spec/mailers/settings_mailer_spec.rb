require "spec_helper"

describe SettingsMailer, type: :mailer do
  let(:user) { create(:user) }

  describe "#settings_changed_email" do
    let(:mail) { SettingsMailer.settings_changed_email(user) }
    MAIL_MESSAGE = "You have successfully updated your settings."

    it "renders the correct headers" do
      expect(mail.from).to include "admin@shrtnr.com"
      expect(mail.to).to include user.email
      expect(mail.subject).to include "Settings Changed"
    end

    it "renders an html layout" do
      expect(mail.html_part.body).to include MAIL_MESSAGE
    end

    it "renders a text layout" do
      expect(mail.text_part.body).to include MAIL_MESSAGE
    end
  end
end
