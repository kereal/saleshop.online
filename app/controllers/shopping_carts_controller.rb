class ShoppingCartsController < ApplicationController

  before_action :extract_shopping_cart

  # GET /cart
  def show
  end

  # GET /cart/add/:product_id
  def add
    @product = Product.find(params[:product_id])
    @shopping_cart.add(@product, @product.price)
    redirect_to cart_path
  end

  # GET /cart/remove/:product_id
  def remove
    @product = Product.find(params[:product_id])
    @shopping_cart.remove(@product)
    redirect_to cart_path
  end

  # GET /cart/clear
  def clear
    @shopping_cart.clear
    redirect_to cart_path
  end

  
  private
  
  def extract_shopping_cart
    shopping_cart_id = session[:shopping_cart_id]
    @shopping_cart = session[:shopping_cart_id] ? ShoppingCart.find(shopping_cart_id) : ShoppingCart.create
    session[:shopping_cart_id] = @shopping_cart.id
  end

end
