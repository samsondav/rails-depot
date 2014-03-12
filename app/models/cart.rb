class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  
  def add_product(product_id)
    current_item = self.line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      # else add a brand new, separate, line item
      product_price = Product.find_by(id: product_id).price
      current_item = line_items.build(product_id: product_id, price: product_price)
    end
    current_item
  end
  
  def decrement_line_item_quantity(line_item_id)
    current_item = self.line_items.find(line_item_id)
    if current_item.quantity > 1
      current_item.quantity -= 1
    else
      current_item.destroy
    end
    current_item
  end
  
  def total_price
    total = 0
    line_items.each do |item|
      total += item.total_price
    end
    total
    # 'official' code follows
#    line_items.to_a.sum {|item| item.total_price}
  end
end