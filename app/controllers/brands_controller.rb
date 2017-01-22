class BrandsController < ApplicationController

  # GET /brands
  def index
    @brands = Brand.all
  end

  # GET /brand/:slug
  def show
    @brand = Brand.friendly.find(params[:slug])
    @title = @brand.title
    @products = @brand.products.preload(:brand, :images)
    render "catalog/show"
  end

end
