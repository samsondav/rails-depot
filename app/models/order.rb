class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  PAYMENT_TYPES = ['Cheque', 'Credit Card', 'Purchase Order']
  validates :name, :address, presence: true
  validates :pay_type, inclusion: { in: self::PAYMENT_TYPES,
                                    message: 'must be a valid payment type'
                                  }
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,
                              message: 'must be a valid email address'
                            }
                            
  def add_line_items_from_cart(cart)
    cart.line_items.each do |li|
      li.cart_id = nil # necessary to unlink item from cart, so item is not automatically destroyed when its parent cart is destroyed
      self.line_items << li
    end
  end
end
