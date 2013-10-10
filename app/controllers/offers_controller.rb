class OffersController < ApplicationController

  def index
    params[:search] = {}
  end

  def search
    @offers = Offer.search(params[:search], params[:page])
    if request.xhr?
      render partial: 'offers/search_result_item', collection: @offers, as: :offer
    else
      render :index
    end
  end

end
