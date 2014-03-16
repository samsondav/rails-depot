class StoreController < ApplicationController
  skip_before_action :authorize
  include SessionCounter
  include CurrentCart
  before_action :set_cart
  
  # GET /store/index (also: GET /)
  def index
    @products = Product.order(:title) # returns array of all product objects ordered alphabetically by title
    increment_counter
  end
end
