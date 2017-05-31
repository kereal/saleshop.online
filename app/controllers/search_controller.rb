class SearchController < ApplicationController

  # GET /search/:query
  def products
    @products = Product.where("title ILIKE %#{params[:query]}%")
  end

end
