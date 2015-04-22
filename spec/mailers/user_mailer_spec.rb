require "spec_helper"

describe UserMailer, :type => :mailer do
  let(:user) { create(:user) }

  describe "#welcome_email" do
    let(:mail) { UserMailer.welcome_email(user) }

    it "renders the correct headers" do
      expect(mail.from).to include "mail@benwoodall.com"
      expect(mail.to).to include user.email
      expect(mail.subject).to include "Welcome to Shortener!"
    end

    it "renders an html layout" do
      expect(mail.html_part.body).to include "You have successfully"
    end
  end

  describe "#settings_change_email" do
    let(:mail) { UserMailer.settings_change_email(user) }

    it "renders the correct headers" do
      expect(mail.from).to include "mail@benwoodall.com"
      expect(mail.to).to include user.email
      expect(mail.subject).to include "Shortener Settings Change Notification"
    end

    it "renders an html layout" do
      expect(mail.html_part.body).to include "Your settings have been changed."
    end
  end
end
