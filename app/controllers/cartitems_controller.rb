class CartitemsController < ApplicationController


  def destroy
    @cartitem = Cartitem.find(params[:id])
    @cartitem.destroy
    redirect_to cart_path(current_cart)
  end  


end
