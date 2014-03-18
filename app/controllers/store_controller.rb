class StoreController < ApplicationController
  skip_before_action :authorize
  include SessionCounter
  include CurrentCart
  before_action :set_cart
  
  # GET /store/index (also: GET /)
  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.order(:title) # returns array of all product objects ordered alphabetically by title
      increment_counter
    end
  end
end
