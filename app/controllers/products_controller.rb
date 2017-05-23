class ProductsController < ApplicationController

  # GET /product/:slug
  def show
    @product = Product.friendly.find(params[:slug])
    render "catalog/product"
  end

  # GET /product/:slug/one_click_buy
  def one_click_buy
    @product = Product.friendly.find(params[:slug])
    @shopping_cart.add(@product, @product.discount_price) 
    redirect_to cart_checkout_path
  end

end
