class OffersController < ApplicationController

  def index
  end

  def search
    @offers = Offer.search(params[:search])
    render :index
  end

end
