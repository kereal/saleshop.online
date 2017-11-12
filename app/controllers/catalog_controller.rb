class CatalogController < ApplicationController


  # GET /sale
  def sale
    @products = Product.search where: { price: 0..1000 },
                              page: params[:page], per_page: Kaminari.config.default_per_page,
                              load: false
    @title = "Распродажа"
    render "catalog/products-show"
  end


  # GET /season/:season_slug(/:gender_slug)
  def season
    season_slug = params.require(:season_slug)
    gender_slug = params.require(:gender_slug) rescue gender_slug = nil
    if gender_slug and not %w(male female).include?(gender_slug)
      raise ActionController::RoutingError.new('Not Found')
    end
    @title = "#{season_slug.capitalize} одежда"
    if season_slug and gender_slug
      @products = Product.search where: { season: season_slug, gender: gender_slug },
                                page: params[:page], per_page: Kaminari.config.default_per_page,
                                load: false
      @title = season_slug.capitalize + case gender_slug
        when 'male' then ' мужская '
        when 'female' then ' женская '
      end << 'одежда'
      render "catalog/products-show"
    else
      render "catalog/genders-show"
    end
  end


end
