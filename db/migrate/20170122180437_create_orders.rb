class CreateOrders < ActiveRecord::Migration[5.0]

  def change

    create_table :orders do |t|
      t.string :name
      t.string :tel
      t.string :delivery_address
      t.string :comment
      t.references :shopping_cart, foreign_key: true
      t.integer :status
      t.timestamps
    end

  end

end
