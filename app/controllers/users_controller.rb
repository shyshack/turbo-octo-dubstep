require 'bcrypt'

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :index, :destroy]
  before_action :admin_user, only: [:index, :destroy]
  before_action :correct_or_admin, only: [:show, :edit, :update]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @lessons = @user.lessons.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit 
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # Before filters
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Confirms on admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    # Confirms on the correct user or admin
    def correct_or_admin
      @user = User.find(params[:id])
      logged_user = current_user
      redirect_to logged_user unless current_user?(@user) || logged_user.admin?
    end
end
