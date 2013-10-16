class Offer < ActiveRecord::Base

  SOURCES = [:odesk, :freelansim]

  PER_PAGE = 16

  scope :newest, -> {order(posted_at: :desc)}

  validates :title, :desc, :ext_id, :posted_at, :source, :offer_url, presence: true
  validates :title, length: {minimum: 3}
  validates :desc, length: {minimum: 10}


  def source_name
    SOURCES[source]
  end

  class << self
    def search(params, page)
      @params = params || {}
      offers = Offer
      offers = add_query_condition if @params[:query]
      offers = add_source_condition if @params[:source] && @params[:source].count != SOURCES.count
      offers.newest.page(page).per(PER_PAGE)
    end

    def import!
      SOURCES.each do |source|
        imported_offers = "offer/#{source}".camelize.constantize.import_offers
        ImportStat.create(
          imported: imported_offers,
          source: source_id(source)
        )
      end
    end

    def delete_old!
      where("created_at <= ?", 1.week.ago).destroy_all
    end

    def imported?(ext_id, source_name)
      where(ext_id: ext_id, source: source_id(source_name)).first
    end

    def source_id(source)
      SOURCES.index(source)
    end

    private

    def add_query_condition
      q = "%#{@params[:query]}%"
      where("offers.title ILIKE ? OR offers.desc ILIKE ?", q, q)
    end

    def add_source_condition
      where("offers.source IN (?)", @params[:source].keys.map(&:to_i))
    end

  end
end
