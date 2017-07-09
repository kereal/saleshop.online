class CategoriesController < ApplicationController


  # GET /category/:slug
  def show

    @category = Category.friendly.find(params[:slug])
    select_categories_ids = @category.subtree_ids

    # доберем через жопу
    if params[:slug] == 'aksessuary'
      select_categories_ids += Category.friendly.find("aksessuary-zhenskie").subtree_ids + Category.friendly.find("aksessuary-muzhskie").subtree_ids
    end
    if params[:slug] == 'sumki'
      select_categories_ids += Category.friendly.find("sumki-zhenskie").subtree_ids
    end


    where_case = { category_id: select_categories_ids }
    where_case.merge!({brand_slug: params[:brand]}) unless params[:brand].blank?
    where_case.merge!({measure: params[:measure]}) unless params[:measure].blank?
    where_case.merge!({color: params[:color]}) unless params[:color].blank?
    where_case.merge!({sale: params[:sale]}) unless params[:sale].blank?


    @products = Product.search where: where_case,
                              page: params[:page], per_page: Kaminari.config.default_per_page,
                              load: false,
                              smart_aggs: false,
                              aggs: {
                                brand: { where: { category_id: select_categories_ids } },
                                measure: { where: { category_id: select_categories_ids } },
                                color: { where: { category_id: select_categories_ids } },
                                sale: { where: { category_id: select_categories_ids } },
                              }



    render "catalog/category-show"

  end


end
