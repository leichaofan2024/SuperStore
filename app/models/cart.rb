class Cart < ApplicationRecord
  has_many :cartitems
  has_many :product, :through => :cartitems, :source => :product

  def add_product_to_cart(product)
    ci = cartitems.build
    ci.product = product
    ci.save
  end
  def total_price
    sum = 0
    cartitems.each do |cartitem|
      if cartitem.product.price.present?
        sum += cartitem.product.price * cartitem.quantity
      end
    end
    sum
  end
end