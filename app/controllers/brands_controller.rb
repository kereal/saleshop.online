class BrandsController < ApplicationController

  # GET /brands
  def index
    @brands = Brand.all
  end

  # GET /brand/:slug
  def show
    @brand = Brand.friendly.find(params[:slug])
    @products = @brand.products.order(:title).preload(:brand, :images)
    render "catalog/brand-show"
  end

end
