class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def admin_user
    redirect_to(root_path) unless signed_in? && current_user.admin?
  end

  def signed_in_user
    unless signed_in?
      respond_to do |format|
        # store_location
        flash[:danger] = "请登录后再进行此操作!"
        redirect_to signin_url
      end
    end
  end

  def actived_user
    unless signed_in? && current_user.is_actived
      respond_to do |format|
        format.html do
          flash[:danger] = "您的账号还未激活，请激活之后再使用!" 
          redirect_to current_user
        end
        format.js do
          render js: "alert('您的账号还未激活，请激活之后再使用!');"
        end
      end
    end
  end
end
