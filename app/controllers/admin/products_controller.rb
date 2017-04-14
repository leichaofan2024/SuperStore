class Admin::ProductsController < AdminController

  before_action :find_product, only:[:edit, :update, :destroy]

  def index
      @products = Product.all
    if params[:category].present?
      @products = Product.where(category_id: params[:category])
    end
  end

  def new
    @product = Product.new
    @categories = Category.all.map{|c| [c.name, c.id]}
    @photo = @product.photos.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      if params[:photos] != nil
        params[:photos]["avatar"].each do |a|
          @photo = @product.photos.create(:avatar => a)
        end
      end
      redirect_to admin_products_path，notice: "成功新增产品！"
    else
      render :new
    end
  end

  def edit
    @categories = Category.all.map{|c| [c.name,c.id]}
  end

  def update
    if params[:photos] != nil
      @product.photos.destroy_all

      params[:photos]["avatar"].each do |a|
        @picture = @produdct.photos.create(:avatar => a)
      end

      @product.update(product_params)
      redirect_to admin_products_path, notice: "更新成功!"
    elsif @product.update(product_params)
      redirect_to admin_products_path
    else 
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, alert: "删除成功！"
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :quantity, :image ,:category_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end

end
