class SettingsMailer < ApplicationMailer
  default from: "admin@shrtnr.com"

  def settings_changed_email(user)
    @user = user
    attachments.inline['logo.png'] = File.read("#{Rails.root}/public/assets/logo.png")
    mail(to: user.email, subject: "Settings Changed")
  end
end
