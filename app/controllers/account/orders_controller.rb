class Account::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order("created_at DESC")
    if params[:status] == "paid"
      @orders = @orders.where(:is_paid => true)
    end
    if params[:status] == "unpaid"
      @orders = @orders.where(:is_paid => false)
    end
  end


end
