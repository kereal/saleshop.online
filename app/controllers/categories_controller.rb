class CategoriesController < ApplicationController


  # GET /category/:slug
  def show

    @category = Category.friendly.find(params[:slug])
    @title = @category.title
    # если эта категория не содержит подкатегории, то возьмем ее товары, если есть подкатегории, то возьмем еще и товары из всех них
    @products = @category.products.preload(:brand, :images)
    @products += Product.where(category: @category.child_ids).preload(:brand, :images) unless @category.leaf?

    render "catalog/show"

  end


end
