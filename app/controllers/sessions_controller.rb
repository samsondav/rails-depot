class SessionsController < ApplicationController
  skip_before_action :authorize
  
  # GET /login
  def new
  end

  # POST /login
  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id # this user is now logged in - proved by session[:user_id]. This is hashed on the client-side so is not manipulable by the client, this making this a secure method of tracking logins.
      redirect_to admin_url
    else
      redirect_to login_url, alert: 'Invalid username/password combination'
    end
  end

  # DELETE /login
  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: 'Successfully logged out'
  end
end
