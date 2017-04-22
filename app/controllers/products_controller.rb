class ProductsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show,:add_to_cart]
  before_action :validates_search_key, only:[:search]
  before_action :find_product, only:[:show, :add_to_cart, :add_to_favorite, :quit_favorite, :pay_now]
  def index
    @products = Product.all.recent
    if params[:favorite] == "yes"
      @products = current_user.products
    end
    if params[:category].present?
      @products = Product.all.where(category_id: params[:category]).recent
    end

    case params[:order]
      when "latest"
        @products = Product.all.recent
      when "price"
        @products = Product.all.order("price DESC")
      when "hot"
        @products = Product.all.sort_by{|product|  product.users.count}.reverse
      end
  end

  def show
    @review = Review.new
    @reivew = @review.pictures.build
    @photos = @product.photos.all 
  end

  def add_to_cart
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将#{@product.title}加入购物车!"
    else
      flash[:notice] = "你的购物车内已有此物品！"
    end
    redirect_to :back
  end

  def add_to_favorite
    @product.add_to_favorite!(current_user)
    redirect_to :back, notice: "加入收藏!"
  end

  def quit_favorite
    @product.quit_favorite!(current_user)
    redirect_to :back, notice: " 取消收藏！"
  end

  def search
    @products = Product.ransack({:title_or_description_cont => @q}).result(distinct: true)
  end
  def pay_now
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
    else
      flash[:warning] = "购物车已有此商品!"
    end
    redirect_to carts_path
  end
  protected

  def validates_search_key
    @q = params[:query_string].gsub(/\\|\'|\/|\?/, "") if params[:query_string].present?
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
