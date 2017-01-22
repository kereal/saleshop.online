class ShoppingCartItem < ApplicationRecord

  acts_as_shopping_cart_item

  
  private

  rails_admin do
    visible false
  end

end