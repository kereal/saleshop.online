class CatalogController < ApplicationController


  # GET /sale
  def sale
    @products = Product.search where: { price: 0..1000 },
                              page: params[:page], per_page: Kaminari.config.default_per_page,
                              load: false
    @title = "Распродажа"
    render "catalog/products-show"
  end


  # GET /season/:season_slug
  def season
    season_slug = params.require(:season_slug)
    if not ["летняя", "зимняя", "демисезонная"].include?(season_slug)
      raise ActionController::RoutingError.new('Not Found')
    end
    @products = Product.search where: { season: params[:season_slug] },
                              page: params[:page], per_page: Kaminari.config.default_per_page,
                              load: false
    @title = "#{season_slug.capitalize} одежда"
    render "catalog/products-show"
  end


end
