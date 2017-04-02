class CategoriesController < ApplicationController


  # GET /category/:slug
  def show

    @category = Category.friendly.find(params[:slug])
    select_categories_ids = [@category.subtree_ids]

    # доберем через жопу
    if params[:slug] == 'aksessuary'
      select_categories_ids += Category.friendly.find("aksessuary-zhenskie").subtree_ids + Category.friendly.find("aksessuary-muzhskie").subtree_ids
    end
    if params[:slug] == 'sumki'
      select_categories_ids += Category.friendly.find("sumki-zhenskie").subtree_ids
    end

    @products = Product.where(category: select_categories_ids).page(params[:page]).preload(:images, :brand)

    render "catalog/category-show"

  end


end
