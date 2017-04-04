class AddArticleToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :article, :string
    Product.update_all(provider_updated_at: Time.now-1.year)
  end
end
