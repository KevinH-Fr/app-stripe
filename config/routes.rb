Rails.application.routes.draw do
  get 'home/index'
  resources :produits

 # resources :checkout, only:[:create]
 # post "checkout/create", to: "checkout#create"

  
 # resources :webhooks, only: [:create]
 # get "success", to: "checkout#success"
 # get "cancel", to: "checkout#cancel"

 # root "produits#index"

 root "home#index"
end
