class SettingsMailer < ApplicationMailer
  default from: "skostojohn@hotmail.com"
  
  def confirmation_email user
    @user = user
    mail(to: user.email, subject: "Confirmation - Shortener Settings Change")
  end
  
end
