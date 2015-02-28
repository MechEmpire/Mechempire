class UserMailer < ApplicationMailer
  def signup_confirm_email(user)
    @user = user
    @url = "localhost:3000"
    mail(to:@user.email, subject: "Welcome to Mechempire")
  end
end
