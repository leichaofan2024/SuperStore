class AddQuantityToCartitem < ActiveRecord::Migration[5.0]
  def change
    add_column :cartitems, :quantity, :integer, default: 1
  end
end
