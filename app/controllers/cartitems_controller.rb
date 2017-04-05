class CartitemsController < ApplicationController

  def update
    @cart = current_cart
    @cartitem = @cart.cartitems.find_by(product_id: params[:id])
    @cartitem.update(cartitem_params)
    redirect_to :back
  end
  def destroy
    @cart = current_cart
    @cartitem = @cart.cartitems.find_by(product_id: params[:id])
    @product = @cartitem.product
    @cartitem.destroy
    redirect_to carts_path, alert: "成功将#{@product.title}从购物车中删除！"
  end


  private

  def cartitem_params
    params.require(:cartitem).permit(:quantity)
  end 
end
