class CreateImages < ActiveRecord::Migration[5.0]

  def change
    create_table :images do |t|
      t.references :product, foreign_key: true
      t.attachment :image
      t.timestamps
    end
  end

end
