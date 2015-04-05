class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  def admin_user
    redirect_to(root_path) unless !current_user.nil? && current_user.admin?
  end
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "请登录后再进行此操作！"
    end
  end
end
