class UserMailer < ApplicationMailer
  default from: "mail@benwoodall.com"

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Shortener!")
  end

  def weekly_stats(user)
    @user = user
    @links = user.links.created_in_last_week
    mail(to: user.email, subject: "Shrtnr Weekly Stats")
  end

end
