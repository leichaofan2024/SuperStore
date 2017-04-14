class Account::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order("created_at DESC")
    if params[:status] == "paid"
      @orders = @orders.where(:aasm_state => "paid")
    end
    if params[:status] == "unpaid"
      @orders = @orders.where(:aasm_state => "order_placed")
    end
  end


end
