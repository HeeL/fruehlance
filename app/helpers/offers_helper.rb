module OffersHelper

  def query_param
    search_param(:query)
  end

  def search_param(param)
    params[:search].try(:[], param)
  end

  def item_num(i)
    i + ((params[:page] || 1).to_i - 1) * Offer::PER_PAGE + 1
  end

  def source_checked?(source_id)
    !params[:search] || !params[:search][:source] || params[:search][:source][source_id.to_s]
  end

end
