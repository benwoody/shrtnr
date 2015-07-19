class UserMailer < ApplicationMailer
  default from: "christo.peak@gmail.com"

  def welcome_email(user)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/public/assets/logo.png")
    @user = user
    mail(to: user.email, subject: "Welcome to Shortener!")
  end

end
