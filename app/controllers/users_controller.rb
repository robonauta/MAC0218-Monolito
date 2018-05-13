class UsersController < ApplicationController
  def new
    @user = User.new 
  end
  def create
#    render plain: params[:user].inspect
    @user = User.new(user_params)
    @user.rank = "user"
    if(@user.save)
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end
  
  private def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :salt, :name, :organization, :rank)
  end
  
end
