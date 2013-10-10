class Offer < ActiveRecord::Base

  SOURCES = [:odesk]

  PER_PAGE = 15

  scope :newest, -> {order(posted_at: :desc)}

  def self.search(params, page)
    @params = params || {}
    offers = Offer
    offers = add_query_condition if @params[:query]
    offers = add_source_condition if @params[:source].count != SOURCES.count
    offers.newest.page(page).per(PER_PAGE)
  end

  def self.import!
    SOURCES.each do |source|
      "offer/#{source}".camelize.constantize.import_offers
    end
  end

  def self.source_id(source)
    SOURCES.index(source)
  end

  private

  def self.add_query_condition
    q = "%#{@params[:query]}%"
    where("offers.title ILIKE ? OR offers.desc ILIKE ?", q, q)
  end

  def self.add_source_condition
    where("offers.source IN (?)", @params[:source].keys.map(&:to_i))
  end

end
