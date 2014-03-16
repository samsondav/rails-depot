class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id # this user is now logged in - proved by session[:user_id]. This is hashed on the client-side so is not manipulable by the client, this making this a secure method of tracking logins.
      redirect_to admin_url
    else
      redirect_to login_url, alert: 'Invalid username/password combination'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: 'Successfully logged out'
  end
end
