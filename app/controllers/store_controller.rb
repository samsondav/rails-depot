class StoreController < ApplicationController
  def index
    @products = Product.order(:title) # returns array of all product objects ordered alphabetically by title
  end
end
