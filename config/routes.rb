Rails.application.routes.draw do
  # resources :products
  get "api/products", to: "products#index"
end
