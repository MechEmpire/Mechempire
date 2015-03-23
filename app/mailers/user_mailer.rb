class UserMailer < ApplicationMailer
  def signup_confirm_email(user)
    @user = user
    @url = "http://198.199.110.154:3000/active?name=#{@user.name}&active_code=#{@user.active_code}"
    mail(to:@user.email, subject: "机甲帝国账号激活邮件")
  end
end
