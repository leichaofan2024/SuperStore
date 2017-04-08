class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  layout "admin"


  def index
      @products = Product.all
    if params[:category].present?
      @products = Product.where(category_id: params[:category])
    end
  end

  def new
    @product = Product.new
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  def create
    @product = Product.new(product_params)
    # @product.category_id = params[:category_id]
    # @product.category = Category.all.where(name: params[:category_id])
    if @product.save
      redirect_to admin_products_path，notice: "成功新增产品！"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Categories.all.map{|c| [c.name,c.id]}
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "更新成功!"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, alert: "删除成功！"
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :quantity, :image ,:category_id)
  end
end
