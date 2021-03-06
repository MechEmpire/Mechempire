module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies[:remember_token] = {
      :value => remember_token,
      :httponly => true
    }
    user.update_attribute(:remember_token, User.hash_custom(remember_token))
    self.current_user = user
  end

  def sign_in_forever(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = {
      :value => remember_token,
      :httponly => true
    }
    user.update_attribute(:remember_token, User.hash_custom(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    if !(cookies[:remember_token].nil?)
      remember_token = User.hash_custom(cookies[:remember_token])
      @current_user ||= User.find_by(remember_token: remember_token)
    end
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.hash_custom(User.new_remember_token))
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
