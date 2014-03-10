class StoreController < ApplicationController
  include SessionCounter
  include CurrentCart
  before_action :set_cart
  
  def index
    @products = Product.order(:title) # returns array of all product objects ordered alphabetically by title
    increment_counter
  end
end
