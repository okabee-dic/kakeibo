module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def logged_in?
    current_user.present?
  end
  
  def check_login
    if logged_in?
    else
      redirect_to new_session_path
    end
  end
  
  def check_user(_id)
    unless current_user.id == _id
      redirect_to books_path
      return false
    end
    return true
  end
end
