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
    @products = Product.where("discount is not null and discount > 0").preload(:brand, :images).page(params[:page])
    @title = "Распродажа"
    render "catalog/products-show"
  end

end
