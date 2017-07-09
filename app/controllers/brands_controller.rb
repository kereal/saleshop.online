class BrandsController < ApplicationController

  # GET /brands
  def index
    @brands = Brand.all
  end

  # GET /brand/:slug
  def show
    @brand = Brand.friendly.find(params[:slug])
    @products = Product.search where: { brand_slug: params[:slug] },
                             page: params[:page], per_page: Kaminari.config.default_per_page,
                             load: false
    render "catalog/brand-show"
  end

end
