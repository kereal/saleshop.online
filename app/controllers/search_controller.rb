class SearchController < ApplicationController

  # GET /search/:query
  def products
    @products = Product.search params[:query], page: params[:page], per_page: Kaminari.config.default_per_page, load: false
  end

end
