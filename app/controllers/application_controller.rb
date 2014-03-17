class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize
  
  protected
  def authorize
    unless User.find_by(id: session[:user_id]) || User.count.zero?
      redirect_to login_url, notice: 'Please log in'
    end
    if User.count.zero?
      flash[:notice] = 'No user accounts created yet! Please create at least one user account.'
    end
  end
end
