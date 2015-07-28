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

  describe "#settings_email" do
    let(:mail) { UserMailer.settings_email(user) }

    it "renders the correct headers" do
      expect(mail.from).to include "mail@benwoodall.com"
      expect(mail.to).to include user.email
      expect(mail.subject).to include "Your Shortener account was updated!"
    end

    it "renders an html layout" do
      expect(mail.html_part.body).to include "Your Shortener account settings were recently changed."
    end

    it "renders a text layout" do
      expect(mail.text_part.body).to include "Your Shortener account settings were recently changed."
    end
  end

end
