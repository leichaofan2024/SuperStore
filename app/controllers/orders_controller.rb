class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def show
    @order = Order.find(params[:id])
    @product_lists = @order.product_lists
  end
  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.total_price
    if @order.save

      current_cart.cartitems.each do |cartitem|
        product_list = ProductList.new
        product_list.order = @order
        product_list.product_name = cartitem.product.title
        product_list.product_price = cartitem.product.price
        product_list.quantity = cartitem.quantity
        product_list.save
      end
      redirect_to order_path(@order)
    else
      render "carts/checkout"
    end
  end

  private

  def order_params
    params.require(:order).permit(:billing_name,:billing_address,:shipping_name,:shipping_address)
  end
end
