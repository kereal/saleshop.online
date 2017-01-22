module CategoryHelper

  def categories_tree_for(categories)
    
    categories.map do |category, nested_categories|
      render("categories/tree_item", category: category) + (nested_categories.size > 0 ? content_tag(:ul, categories_tree_for(nested_categories), class: "sub") : nil)
    end.join.html_safe
  
  end

end
