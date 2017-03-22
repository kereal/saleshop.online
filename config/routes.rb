Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'pages#index'

  get '/sale(/page/:page)', to: 'pages#sale', as: :sale

  get '/brands', to: 'brands#index'
  get '/brand/:slug(/page/:page)', to: 'brands#show', as: :brand

  get '/categories', to: 'categories#index'
  get '/category/:slug(/page/:page)', to: 'categories#show', as: :category

  get '/product/:slug', to: 'products#show', as: :product

  get '/page/:slug', to: 'pages#show', as: :page

  get '/cart', to: 'shopping_carts#show'
  get '/cart/add/:product_id', to: 'shopping_carts#add', as: :cart_add
  get '/cart/remove/:product_id', to: 'shopping_carts#remove', as: :cart_remove
  get '/cart/clear', to: 'shopping_carts#clear'
  get '/cart/checkout', to: 'shopping_carts#checkout'
  post '/cart/create_order', to: 'shopping_carts#create_order'
  get '/cart/thanks', to: 'shopping_carts#thanks'


end
