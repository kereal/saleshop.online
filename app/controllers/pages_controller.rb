class PagesController < ApplicationController

  # GET /
  def index
    @brands = Brand.limit(10)
  end

  # GET /page/:slug
  def show
    @page = Page.friendly.find(params[:slug])
  end

end
