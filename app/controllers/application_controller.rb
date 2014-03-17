class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize
  
  protected
  def authorize
    if User.count.zero?
      # do not require login if no users are yet present in database
      flash[:notice] = 'No user accounts created yet! Please create at least one user account.'
    elsif request.format != Mime::HTML
      # do http auth
      authenticate_or_request_with_http_digest do |username, password|
        user = User.find_by(name: username)
        return user && user.authenticate(password)
      end
    else
      # do fancy rails auth
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: 'Please log in'
      end
    end
  end
end
