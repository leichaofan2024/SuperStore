class Cart < ApplicationRecord
  has_many :cartitems

  def add_product_to_cart(product)
    ci = cartitems.build
    ci.product = product
    ci.save
  end

end
