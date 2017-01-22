class Order < ApplicationRecord

  belongs_to :shopping_cart

  validates :name, :tel, presence: true, length: { minimum: 2 }


  private

  rails_admin do
    list do
      exclude_fields :shopping_cart
    end
  end

end
