class AddAncestryToCategories < ActiveRecord::Migration[5.0]

  def change
    add_column :categories, :ancestry, :string, index: true
    Category.build_ancestry_from_parent_ids!
    remove_column :categories, :parent_id, :string 
  end

end
