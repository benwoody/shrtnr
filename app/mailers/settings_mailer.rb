class SettingsMailer < ApplicationMailer
  default from: "timhall@someemail.com"

  def update_email(user)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/public/assets/logo.png")
    @user = user
    mail(to: user.email, subject: "You have updated your settings!")
  end

end
