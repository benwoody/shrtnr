class SettingsMailer < ApplicationMailer
  
  def update_email(user)
    @user = user
    mail(to: user.email, subject: "You updated your settings")
  end
end
