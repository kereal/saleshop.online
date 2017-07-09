class PagesController < ApplicationController

  # GET /
  def index
    @brands = Brand.limit(15)
  end

  # GET /page/:slug
  def show
    @page = Page.friendly.find(params[:slug])
  end

  # GET /sale
  def sale
    @products = Product.search where: { price: 0..1000 },
                              page: params[:page], per_page: Kaminari.config.default_per_page,
                              load: false
    @title = "Распродажа"
    render "catalog/products-show"
  end

end
