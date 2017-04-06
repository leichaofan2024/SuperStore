class Cart < ApplicationRecord
  has_many :cartitems, dependent: :destroy
  has_many :products, :through => :cartitems, :source => :product
  belongs_to :user
  def clean!
    cartitems.delete_all
  end
  def add_product_to_cart(product)
    ci = cartitems.build
    ci.product = product
    ci.title = product.title
    ci.save
  end
  def total_price
    sum = 0
    cartitems.each do |cartitem|
      if cartitem.product.present?
        sum += cartitem.product.price * cartitem.quantity
      end
    end
    sum
  end
end
