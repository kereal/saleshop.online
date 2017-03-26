class ShoppingCartsController < ApplicationController

  # GET /cart
  def show
  end

  # GET /cart/add/:product_id
  def add
    @product = Product.find(params[:product_id])
    @shopping_cart.add(@product, @product.discount_price)
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

  # GET /cart/checkout
  def checkout
    @order = Order.new
  end

  # POST /cart/create_order
  def create_order
    @order = Order.new(order_params)
    @order.shopping_cart = @shopping_cart
    if @order.save
      redirect_to cart_thanks_path
      session[:shopping_cart_id] = nil
      OrderMailer.email_to_admin(@order.id).deliver_later
    else
      render "cart/checkout"
    end
  end

  # GET /cart/thanks
  def thanks
  end

  
  private

  def order_params
    params.require(:order).permit(:name, :tel, :delivery_address, :comment)
  end
  
end
