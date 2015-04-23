class SessionsController < ApplicationController
  def create
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if user
      session[:user_id], session[:location] = user.id, set_user_location
      flash[:success] = "Welcome back, #{user.name}!"
      redirect_to root_url
    else
      @user = User.create_with_omniauth(auth)
      render '/users/new'
    end
  end

  def destroy
<<<<<<< HEAD
    # binding.pry
=======
>>>>>>> 97694736f34bcddd9c91caa82a3067ca3e2138fd
    session.destroy
    flash[:danger] = "Signed Out!"
    redirect_to root_url
  end

  private
  def auth
    request.env["omniauth.auth"]
  end
end
