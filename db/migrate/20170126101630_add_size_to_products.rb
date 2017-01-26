class AddSizeToProducts < ActiveRecord::Migration[5.0]

  def change

    add_column :products, :size, :string

    Product.find_each do |product|
      product.size = ["S", "M", "L", "XL", 37, 38, 39, 40].sample
      product.save
    end

  end

end
