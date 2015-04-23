class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :follower, :followed]
  before_action :signed_in_user, only: [:edit, :update, :admin, :following, :unfollowing, :re_active]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :admin]
  before_action :actived_user, only: [:update,:following,:unfollowing]

  # GET /users
  # GET /users.json
  def index
    @users = User.order("score DESC").page(params[:page]).per(10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    store_location
  end

  # GET /users/new
  def new
    store_location
    if !signed_in?
      @user = User.new
    else
      flash[:warning] = "您已登录，请退出后再进行注册操作！"
      redirect_back_or current_user
    end
  end

  def re_active
    if !current_user.is_actived && UserMailer.signup_confirm_email(current_user).deliver
      flash[:warning] = "邮件发送成功，请登录您的注册邮箱查看!"
      redirect_to current_user
    else
      flash[:warning] = "邮件发送失败, 请重试, 如多次未成功请联系管理员!"
      redirect_to current_user
    end
  end

  # GET /users/1/edit
  def edit
    store_location
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    
    @user.name = @user.email.split("@")[0].titleize
    @user.active_code = rand(Time.now.to_i).to_s
    @user.is_actived = false
    @user.admin  = false
    @user.join_time = Time.now

    respond_to do |format|
      if @user.save
        UserMailer.signup_confirm_email(@user).deliver
        sign_in @user

        format.html { redirect_back_or @user, notice: '注册成功，感谢您注册本站，请登录注册邮箱激活您的账户!' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to edit_user_path(@user), notice: '个人信息更新成功!' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: '删除用户成功!' }
      format.json { head :no_content }
    end
  end

  def active
    @user = User.find_by(name:params[:name])
    if @user != nil && !@user.is_actived && @user.active_code == params[:active_code]
      @user.update_attribute(:is_actived, true)
      flash[:success] = "恭喜您，您已经成功激活了您的账户！"
    elsif @user != nil && @user.is_actived
      flash[:warning] = "您的账户已经处于激活状态，请勿重复激活！"
    else
      flash[:danger] = "激活失败！"
    end

    redirect_to root_path
  end

  def following
    followed_user = User.find(params['followed_id'])

    respond_to do |format|
      unless followed_user.nil?
        unless current_user.following.include?(followed_user)
          current_user.following.push(followed_user)
          followed_user.follower.push(current_user)
          @follower_count = current_user.following.count
          format.js
        else
          format.js do
            render js: "alert('已关注，请勿重新关注！');"
          end
        end
      else
        format.js do
          render js: "alert('关注用户不存在！');"
        end
      end
    end
  end

  def unfollowing
    unfollowed_user = User.find(params['unfollowed_id'])

    respond_to do |format|
      unless unfollowed_user.nil?
        if current_user.following.include?(unfollowed_user)
          current_user.following.delete(unfollowed_user)
          unfollowed_user.follower.delete(current_user)
          @follower_count = current_user.following.count
          format.js
        else
          render js: "alert('未关注，请先关注！');"
        end
      else
        format.js do
          render js: "alert('取关用户不存在！');"
        end
      end
    end
  end

  def follower
  end

  def followed
  end

  private
    def set_user
      @user = User.find(params[:id])
      if @user.nil?
        render :file => 'public/404.html'
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def user_params
      params.require(:user).permit(:name, 
                                   :email, 
                                   :password, 
                                   :password_confirmation,
                                   :sex,
                                   :motto,
                                   :blog)
    end
end
