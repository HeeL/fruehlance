class Offer < ActiveRecord::Base

  SOURCES = [:odesk]

  PER_PAGE = 15

  scope :newest, -> {order(posted_at: :desc)}

  class << self
    def search(params, page)
      @params = params || {}
      offers = Offer
      offers = add_query_condition if @params[:query]
      offers = add_source_condition if @params[:source].count != SOURCES.count
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
