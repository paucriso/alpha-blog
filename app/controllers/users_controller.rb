class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index 
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def show 
    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save 
      flash[:notice] = "welcome to the Alpha blog #{@user.username}. Sign up successfully"
      session[:user_id] = @user.id
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit 
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy 
    @user.destroy
    session[:user_id] = nil if @user == currrent_user
    flash[:notice] = "Account and all associated articles deleted"
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def find_user 
    @user = User.find(params[:id])
  end

  def require_same_user 
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit your account"
      redirect_to @user
    end
  end
end