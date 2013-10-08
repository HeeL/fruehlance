module OffersHelper

  def query_param
    search_param(:query)
  end

  def search_param(param)
    params[:search].try(:[], param)
  end

end
