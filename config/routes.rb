Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  namespace :admin do
    resources :products
    resources :orders
  end
  resources :cartitems
  resources :products do
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
    end
  end
  namespace :account do
    resources :orders
  end
end
