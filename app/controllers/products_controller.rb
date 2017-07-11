class ProductsController < ApplicationController

  # GET /product/:slug
  def show
    @product = Product.friendly.find(params[:slug])
    render "catalog/product"
  end

end
