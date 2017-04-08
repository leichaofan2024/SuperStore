Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  namespace :admin do
    resources :categories
    resources :products
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end
  resources :cartitems
  resources :products do
    collection do
      get :search
    end  
    member do
      post :add_to_cart
      post :add_to_favorite
      post :quit_favorite
    end
  end
  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end
  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end
  namespace :account do
    resources :orders
  end
end
