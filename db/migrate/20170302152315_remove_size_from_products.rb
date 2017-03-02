class RemoveSizeFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :size, :string
  end
end
