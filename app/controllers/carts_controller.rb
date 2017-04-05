class CartsController < ApplicationController

  def clean
    current_cart.clean!
    redirect_to carts_path, alert: "你已清空购物车！"
  end
end
