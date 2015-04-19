class SettingsMailer < ApplicationMailer
  default from: "admin@shrtnr.com"

  def settings_change_email(user, previous_settings)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/public/assets/logo.png")
    @user = user
    @previous_settings = previous_settings
    mail(to: user.email, subject: "Your settings have changed")
  end
end
