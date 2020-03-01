Rails.application.routes.draw do
  get    "api/products",         to: "products#index"
  get    "api/cart",             to: "cart#index"
  post   "api/cart",             to: "cart#create"
  delete "api/cart/:product_id", to: "cart#destroy"

  match "*unmatched_route", to: "application#not_found", via: :all
end
