class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :destroy, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :facecontroll, only: [:new, :create]
  before_action :show_controll, only: [:show]
  
  def index
    @users = User.all
    @users = User.paginate(page: params[:page])  
  end

  def destroy
    if params[:id] != current_user.id
      User.find(params[:id]).destroy
      flash[:success] = "User deleted."
    else
      flash[:error] = "You cannot delete your profile"
    end
    
    redirect_to users_url
  end


  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order('created_at DESC').paginate(page: params[:page]) 
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

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  

  private 

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)  	
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  def show_controll
     facecontroll true if !signed_in?
  end
  
  def facecontroll flag = false
    if signed_in? || flag
      redirect_to root_url
    end 
  end

end
