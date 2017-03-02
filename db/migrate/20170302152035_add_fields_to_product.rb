class AddFieldsToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :gender, :integer
    add_column :products, :discount, :integer
    add_column :products, :country, :string
    add_column :products, :provider_images, :string
    add_column :products, :provider_product_id, :integer
    add_column :products, :provider_updated_at, :datetime
    add_column :products, :properties, :text
  end
end
