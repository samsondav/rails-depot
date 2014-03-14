class AddShipDateToOrders < ActiveRecord::Migration
  def up
    add_column :orders, :ship_date, :datetime
  end
  def down
    remove_column :orders, :ship_date, :datetime
  end
end
