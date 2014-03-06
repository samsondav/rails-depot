class StoreController < ApplicationController
  def index
    @products = Product.order(:title) # returns array of all product objects ordered alphabetically by title
  end
end

# TODO: why is the text below in this file??
# require File.dirname(__FILE__) + '/../../test/controllers/store_controller_test'
