class Offer::Odesk
  require 'open-uri'

  API_URL = 'https://www.odesk.com/'
  URL = 'https://www.odesk.com/'
  OFFERS_PATH = 'api/profiles/v1/search/jobs.json'

  class << self
    def import_offers
      imported_offers = 0
      get_offers.each do |offer|
        offer.symbolize_keys!
        next if Offer.imported?(offer[:op_recno], :odesk)
        new_offer = Offer.create(
          title:     offer[:op_title],
          source:    Offer.source_id(:odesk),
          desc:      offer[:op_description],
          posted_at: get_date(offer[:op_ctime]),
          ext_id:    offer[:op_recno],
          offer_url: offer_url(offer[:op_recno])
        )
        imported_offers += 1 if new_offer.persisted?
      end
      imported_offers
    end

    private

    def get_date(seconds)
      Time.at(seconds.to_s.slice(0, 10).to_i).to_date
    end

    def offer_url(offer_id)
      "#{URL}/job/#{offer_id}/apply/"
    end

    def get_offers
      JSON.parse(fetch_offers)['jobs']['job'] rescue []
    end

    def fetch_offers
      fetch_path(OFFERS_PATH)
    end

    def fetch_path(path)
      File.read(open("#{API_URL}#{path}"))
    end
  end

end