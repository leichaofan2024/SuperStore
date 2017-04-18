class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.product = @product
    if @review.save
      if params[:pictures] != nil
        params[:pictures]["avatar"].each do |a|
          @picture = @review.pictures.create(:avatar => a)
        end
      end
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @review.pictures.destroy_all
    @review.destroy

    redirect_to product_path(@product)
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
