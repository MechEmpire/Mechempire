class UserMailer < ApplicationMailer
  def signup_confirm_email(user)
    @user = user
    @url = "http://mechempire.cn/active?name=#{@user.name}&active_code=#{@user.active_code}"
    mail(to:@user.email, subject: "机甲帝国账号激活邮件(请勿直接回复)")
  end
end
