class CategoriesController < ApplicationController


  # GET /category/:slug
  def show

    @category = Category.friendly.find(params[:slug])
    select_categories_ids = [@category.subtree_ids]

    # доберем через жопу
    if params[:slug] == 'aksessuary'
      select_categories_ids += Category.friendly.find("aksessuary-8").subtree_ids + Category.friendly.find("aksessuary-83").subtree_ids
    end
    if params[:slug] == 'sumki'
      select_categories_ids += Category.friendly.find("sumki-38").subtree_ids
    end

    @products = Product.where(category: select_categories_ids).page(params[:page]).preload(:images, :brand)

    render "catalog/category-show"

  end


  private

    # получаем продукты категории и всех ее детей
    def get_full_products(category)
      products = category.products
      
    end


end
