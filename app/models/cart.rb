class Cart < ApplicationRecord
  has_many :cartitems
  has_many :product, :through => :cartitems, :source => :product 

  def add_product_to_cart(product)
    ci = cartitems.build
    ci.product = product
    ci.save
  end

end
