Rails.application.routes.draw do
  resources :produits

  resources :checkout, only:[:create]
  post "checkout/create", to: "checkout#create"

  
  root "produits#index"
end
