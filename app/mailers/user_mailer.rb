class UserMailer < ApplicationMailer
  default from: "noreply@friend.com"

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Friend!")
  end
end
