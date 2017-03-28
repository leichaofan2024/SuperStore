class ProductsController < ApplicationController

  def index
    @products = Product.all
    if params[:favorite] == "yes"
      @products = current_user.products
    end

  end

  def show
    @product = Product.find(params[:id])
  end


  def add_to_favorite
    @product = Product.find(params[:id])
    @product.add_to_favorite!(current_user)
    redirect_to products_path, notice: "加入收藏!"
  end

  def quit_favorite
    @product = Product.find(params[:id])
    @product.quit_favorite!(current_user)
    redirect_to products_path, notice: " 取消收藏！"
  end

end
