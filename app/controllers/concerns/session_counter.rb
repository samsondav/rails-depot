# A SessionCounter concern that makes the counter_increment function available to all controllers
module SessionCounter
  extend ActiveSupport::Concern
  
private
  def increment_counter
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
  end
end