class SettingsMailer < ApplicationMailer
  default from: "admin@shrtnr.com"

  def settings_change_email(user)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/public/assets/logo.png")
    @user = user
    mail(to: user.email, subject: "Your settings have changed")
  end
end
