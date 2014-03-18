class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize
  before_action :set_i18n_locale_from_params
  
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
  
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end
  
  def default_url_options
    { locale: I18n.locale }
  end
end
