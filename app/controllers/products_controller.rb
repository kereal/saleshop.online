class ProductsController < ApplicationController

  skip_before_action :extract_shopping_cart, only: [:fast_view]
  

  # GET /product/:slug
  def show
  
    @product = Product.friendly.find(params[:slug])
    render "catalog/product"
  
  end

  
  # GET /product/:slug/fast_view
  def fast_view

    if request.xhr?
      @product = Product.friendly.find(params[:slug])
      render "catalog/product_fast_view", layout: false
    else
      head :not_found
    end

  end


end
