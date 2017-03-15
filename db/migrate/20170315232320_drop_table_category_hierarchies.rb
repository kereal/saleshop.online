class DropTableCategoryHierarchies < ActiveRecord::Migration[5.0]
  
  def change
    drop_table :category_hierarchies
  end

end
