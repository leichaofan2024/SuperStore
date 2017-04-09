class ProductsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  before_action :validates_search_key, only:[:search]
  def index
    @products = Product.all
    if params[:favorite] == "yes"
      @products = current_user.products
    end
    if params[:category].present?
      @products = Product.all.where(category_id: params[:category])
    end

  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将#{@product.title}加入购物车!"
    else
      flash[:notice] = "你的购物车内已有此物品！"
    end
    redirect_to :back
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

  def search
    @products = Product.ransack({:title_or_description_cont => @q}).result(distinct: true)
  end
  protected
  def validates_search_key
    @q = params[:query_string].gsub(/\\|\'|\/|\?/, "") if params[:query_string].present?
  end
end
