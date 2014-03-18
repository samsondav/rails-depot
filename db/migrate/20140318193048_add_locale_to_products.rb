class AddLocaleToProducts < ActiveRecord::Migration
  def up
    add_column :products, :locale, :string
  end
  def down
    remove_column :products
  end
end
