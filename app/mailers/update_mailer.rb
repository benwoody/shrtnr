class UpdateMailer < ApplicationMailer

  default from: "notifications@shrt.nr"

  def settings_email(user, previous)
puts ">>>> In email sender"
    attachments.inline['logo.png'] = File.read("#{Rails.root}/public/assets/logo.png")
    @user = user
    @previous = previous
    mail(to: @user.email, subject: "Your settings at Shrt.nr have been changed")
  end

end
