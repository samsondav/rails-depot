# Putting the set_cart method here allows sharing across multiple controllers
# It is marked as private so that rails will never make it available as an action on the controller
module CurrentCart
  extend ActiveSupport::Concern
  
private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end