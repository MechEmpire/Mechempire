class SessionsController < ApplicationController
  def new
    if signed_in?
      flash[:warning] = "您已登录，无需重复登录！"
      redirect_to current_user
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if params[:session][:remember]
        sign_in_forever user
      else
        sign_in user
      end
      redirect_to user
    else
      flash[:danger] = '用户名或密码错误!'
      render 'new'
    end
  end

  def destory
    sign_out
    redirect_to root_path
  end
end
