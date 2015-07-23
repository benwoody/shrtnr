class UserMailer < ApplicationMailer
  default from: "mail@benwoodall.com"

  def welcome_email(user)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/public/assets/logo.png")
    @user = user
    mail(to: user.email, subject: "Welcome to Shortener!")
  end

  def update_email(user)
  	attachments.inline['logo.png'] = File.read("#{Rails.root}/public/assets/logo.png")
  	@user = user
  	mail(to: user.email, subject: "Your account has been updated!")
  end

end
