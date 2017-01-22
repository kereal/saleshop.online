class PagesController < ApplicationController

  def index
    @brands = Brand.limit(10)
  end

end
