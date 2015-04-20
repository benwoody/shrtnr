require "spec_helper"

RSpec.describe UpdateMailer, type: :mailer do
  let(:user) { create(:user) }

  describe "#settings_email" do
    let(:mail) { UpdateMailer.settings_email(user, user) }

    it "renders the correct headers " do
      expect(mail.from).to include "notifications@shrt.nr"
      expect(mail.to).to include user.email
      expect(mail.subject).to include "Your settings at Shrt.nr have been changed"
    end

    it "renders an html layout " do
      expect(mail.html_part.body).to include "<p>Your settings at Shrt.nr have been changed:"
    end

  end

end
