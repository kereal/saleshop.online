class CreatePages < ActiveRecord::Migration[5.0]

  def change

    create_table :pages do |t|
      t.string :title
      t.string :slug, unique: true, index: true
      t.text :content
      t.timestamps
    end

  end

end
