class ProductsController < ApplicationController

  
  # GET /product/:slug
  def show
  
    @product = Product.friendly.find(params[:slug])
    render "catalog/product"
  
  end

  
  # GET /product/:slug/fast_view
  def fast_view
  
    @product = Product.friendly.find(params[:slug])
    render "catalog/product_fast_view", layout: false

    # respond_to do |format|
    #   format.js {
    #     @product = Product.friendly.find(params[:slug])
    #     render "catalog/product", layout: false
    #   }
    #   format.all { head :not_found }
    # end

  end


end
