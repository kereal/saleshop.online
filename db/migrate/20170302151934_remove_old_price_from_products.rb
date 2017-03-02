class RemoveOldPriceFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :old_price, :string
  end
end
