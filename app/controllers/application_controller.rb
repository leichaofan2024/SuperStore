class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_is_admin
    if !current_user.admin?
      redirect_to "/"
      flash[:alert] = "你不是管理员"
    end
  end

  helper_method :current_cart


  def current_cart
    @current_cart ||= find_cart
  end


  private

  def find_cart
    cart = Cart.find_by(:user_id => session[:user_id])
    if cart.blank?
      cart = Cart.create
      cart.user = current_user
    end
    session[:user_id] = cart.user_id
    return cart
  end
end
