class ShoppingCart < ApplicationRecord

  acts_as_shopping_cart


  private

    rails_admin do
      visible false
    end


end