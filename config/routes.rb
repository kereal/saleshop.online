Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'pages#index'

  # всякие кастомные выборки товаров
  get '/sale(/page/:page)', to: 'catalog#sale', as: :sale
  get '/season/:season_slug(/:gender_slug(/page/:page))', to: 'catalog#season', as: :season, constraints: lambda { |req| %w(летняя зимняя демисезонная).include? req.params[:season_slug] }

  get '/search/:query', to: 'search#products', as: :search

  get '/brands', to: 'brands#index'
  get '/brand/:slug(/page/:page)', to: 'brands#show', as: :brand

  get '/categories', to: 'categories#index'
  get '/category/:slug(/page/:page)', to: 'categories#show', as: :category

  get '/product/:slug', to: 'products#show', as: :product
  get '/product/:slug/fast_view', to: 'products#fast_view', as: :product_fast_view

  get '/page/:slug', to: 'pages#show', as: :page

  scope :cart, controller: 'shopping_carts' do
    get '/', action: :show, as: :cart
    get 'add/:product_id', action: :add, as: :cart_add
    get 'remove/:product_id', action: :remove, as: :cart_remove
    get :clear, as: :cart_clear
    get :checkout, as: :cart_checkout
    post :create_order, as: :cart_create_order
    get :thanks, as: :cart_thanks
  end

  scope :wishlist, controller: 'wishlists' do
    get '/', action: :show, as: :wishlist
    get 'add/:product_id', action: :add, as: :wishlist_add
    get 'remove/:product_id', action: :remove, as: :wishlist_remove
    get :clear, as: :wishlist_clear
  end

  scope :subscribers, controller: 'subscribers' do
    post :subscribe, as: :subscribers_subscribe
    get 'confirm/:token', action: :confirm, as: :subscribers_confirm
    get 'unsubscribe/:token', action: :unsubscribe, as: :subscribers_unsubscribe
  end

end
