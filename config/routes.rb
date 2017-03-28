Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  namespace :admin do
    resources :products
  end
  resources :products do
    member do
      post :add_to_cart 
      post :add_to_favorite
      post :quit_favorite
    end
  end
end
