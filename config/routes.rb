Rails.application.routes.draw do
  get 'home/index'
  resources :produits

  resources :checkout, only:[:create]
  post "checkout/create", to: "checkout#create"

  get "success", to: "checkout#success"
  get "cancel", to: "checkout#cancel"

  resources :webhooks, only: [:create]
  get "success", to: "checkout#success"
  get "cancel", to: "checkout#cancel"

  root "produits#index"

  post "produits/add_to_cart/:id", to: "produits#add_to_cart", as: "add_to_cart"
  delete "produits/remove_from_cart/:id", to: "produits#remove_from_cart", as: "remove_from_cart"


end
