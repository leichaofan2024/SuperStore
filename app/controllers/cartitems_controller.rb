class CartitemsController < ApplicationController

  def update
    @cart = current_cart
    @cartitem = @cart.cartitems.find_by(product_id: params[:id])
    if @cartitem.product.quantity >= cartitem_params[:quantity].to_i
      @cartitem.update(cartitem_params)
      flash[:notice] = "成功变更数量 "
    else
      flash[:warning] = "数量不足以加入购物车"
    end
    redirect_to carts_path
  end
  def destroy
    @cart = current_cart
    @cartitem = @cart.cartitems.find(params[:id])
    # @product = @cartitem.product
    @cartitem.destroy
    redirect_to carts_path, alert: "成功将#{@cartitem.title}从购物车中删除！"
  end


  private

  def cartitem_params
    params.require(:cartitem).permit(:quantity)
  end
end
