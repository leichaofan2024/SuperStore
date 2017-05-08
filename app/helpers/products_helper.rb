module ProductsHelper
  def render_active(index)
    if index == 0
      "active"
    end
  end
  def render_product_favorite_state(product)
     if !product.is_favorited?(current_user)
       link_to("",add_to_favorite_product_path(product),:remote => true, method: :post, class: "show-heart1 fa fa-heart ",style:"text-decoration:none;color:rgba(111,113,111 ,1);")
     else
       link_to("", quit_favorite_product_path(product),:remote=>true, method: :post,  class: "show-heart2 fa fa-heart ",style:"text-decoration:none;color:red;")
     end
  end
end
