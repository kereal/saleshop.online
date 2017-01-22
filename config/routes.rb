Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'pages#index'

  get "/brands", to: "brands#index"
  get "/brand/:slug", to: "brands#show", as: :brand

  get "/categories", to: "categories#index"
  get "/category/:slug", to: "categories#show", as: :category

  get "/product/:slug", to: "products#show", as: :product

  get "/page/:slug", to: "pages#show", as: :page

  get "/cart", to: "shopping_carts#show"
  get "/cart/add/:product_id", to: "shopping_carts#add", as: :cart_add
  get "/cart/remove/:product_id", to: "shopping_carts#remove", as: :cart_remove
  get "/cart/clear", to: "shopping_carts#clear"

end
