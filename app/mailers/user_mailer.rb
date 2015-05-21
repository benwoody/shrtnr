class UserMailer < ApplicationMailer
  default from: "mail@benwoodall.com"

  def welcome_email(user)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/public/assets/logo.png")
    @user = user
    mail(to: user.email, subject: "Welcome to Shortener!")
  end

  def welcome_email(user)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/public/assets/logo.png")
	@user = user
	mail(to: user.email, subject: "Welcome to Shortener!")
  end

  def change_email(user)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/public/assets/logo.png")
	@user = user
	mail(to: user.email, subject: "Changed Email Notification")
  end
end
