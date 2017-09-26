class WishlistsController < ApplicationController

  skip_before_action :extract_shopping_cart, except: [:show]


  # GET /wishlist
  def show
    @wishlist = []
    if cookies.signed[:wlids]
      product_ids = cookies.signed[:wlids]
      product_ids = product_ids.map(&:to_i).reject(&:zero?)  # чистим: оставляем только числа
      @wishlist = Product.where(id: product_ids) unless product_ids.empty?
    end
  end


  # GET /wishlists/add/:product_id
  def add
    ids = cookies.permanent.signed[:wlids] || []
    cookies.permanent.signed[:wlids] = ids | [params[:product_id].to_i]  # кладем только уникальное значение
    redirect_back(fallback_location: root_path)
  end


  # GET /wishlists/remove/:product_id
  def remove
    if cookies.signed[:wlids]
      ids = cookies.signed[:wlids] - [params[:product_id].to_i]
      cookies.permanent.signed[:wlids] = ids.empty? ? nil : ids
    end
    redirect_back(fallback_location: root_path)
  end


  # GET /wishlist/clear
  def clear
    cookies.permanent.signed[:wlids] = nil
    redirect_back(fallback_location: root_path)
  end


end
