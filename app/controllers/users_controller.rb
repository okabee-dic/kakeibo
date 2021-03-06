class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create 
    @user = User.new(user_params)
    
    if @user.save
      if @user
        session[:user_id] = @user.id
        session[:bookselect] = nil
        redirect_to user_path(@user.id)
      else
        flash[:danger] = 'ログインに失敗しました'
        redirect_to new_session_path
      end
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
    
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :sex, :birth)
  end
end
