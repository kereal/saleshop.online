class CreateProducts < ActiveRecord::Migration[5.0]

  def change

    create_table :products do |t|
      t.string :title
      t.references :category, foreign_key: true
      t.references :brand, foreign_key: true
      t.decimal :price, precision: 10, scale: 2
      t.decimal :old_price, precision: 10, scale: 2
      t.text :description
      t.string :slug, unique: true
      t.timestamps
    end

  end

end
