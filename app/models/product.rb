class Product < ActiveRecord::Base
  validates :title, :description, :image_url, presence: :true
  validates :title, length: {minimum: 10, message: "must be at least 10 characters"}
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
            with:  %r{\.(gif|jpe{0,1}g|png)\z}i,
            message: 'must be a URL for GIF, JPG or PNG image' 
  }
end
