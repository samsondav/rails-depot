class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  
  validates :title, :description, :image_url, presence: :true
  validates :title, length: {minimum: 10, message: "must be at least 10 characters"}
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
            with:  %r{\.(gif|jpe{0,1}g|png)\z}i,
            message: 'must be a URL for GIF, JPG or PNG image' }
  validates :locale, inclusion: { in: LANGUAGES.map {|l| l[1]},
            message: "%{value} is not a valid locale" }
  
  def self.latest
    Product.order(:updated_at).last #return latest updated product (for caching purposes), order clearly sorts by oldest->newest
  end

private
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line items present')
      return false
    end
  end  
end
