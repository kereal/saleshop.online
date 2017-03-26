class AddGenderToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :gender, :integer
  end
end
