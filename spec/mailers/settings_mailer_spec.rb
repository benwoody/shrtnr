require "spec_helper"


describe SettingsMailer, :type => :mailer do
  let(:user) { create(:user) }

  describe "#update_email" do
    let(:mail) { SettingsMailer.update_email(user) }

    it "renders the correct headers" do
      expect(mail.from).to include "timhall@someemail.com"
      expect(mail.to).to include user.email
      expect(mail.subject).to include "You have updated your settings!"
    end

    it "renders an html layout" do
      expect(mail.html_part.body).to include "You have successfully updated your settings on Shortener!"
    end
  end
end
