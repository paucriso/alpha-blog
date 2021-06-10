class UsersController < ApplicationController

  def show 
    find_user
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save 
      flash[:notice] = "welcome to the Alpha blog #{@user.username}. Sign up successfully"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit 
    find_user
  end

  def update
    find_user
    if @user.update(user_params)
      flash[:notice] = "User updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def find_user 
    @user = User.find(params[:id])
  end
end