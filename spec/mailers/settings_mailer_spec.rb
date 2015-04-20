require "spec_helper"

describe SettingsMailer, :type => :mailer do
    let(:user) { create(:user) }

  describe "#confirmation_email" do
    let(:mail) { SettingsMailer.confirmation_email(user) }

    it "renders the correct headers" do
      expect(mail.from).to include "skostojohn@hotmail.com"
      expect(mail.to).to include user.email
      expect(mail.subject).to include "Confirmation - Shortener Settings Change"
    end

    it "renders an html layout" do
      expect(mail.html_part.body).to include "updated your Shortener settings"
    end
  end
end