class AddProviderTitleToCategories < ActiveRecord::Migration[5.0]

  def change
    
    add_column :categories, :provider_title, :string
  
    Category.all.each do |category|
      category.provider_title = category.title
      category.save
    end
  
  end

end
