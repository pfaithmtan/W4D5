class UsersController < ApplicationController
  def index
    render :index
  end
  
  def new
    @user = User.new
    # going to set a nil user
    
    render :new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      render :index
    else 
      render :new
    end 
  end
  
  private 
  
  def user_params
    params.require(:user).permit(:email, :password)
  end 
end