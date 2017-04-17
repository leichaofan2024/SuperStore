class AddTitleToCartitem < ActiveRecord::Migration[5.0]
  def change
    add_column :cartitems, :title, :string
  end
end
