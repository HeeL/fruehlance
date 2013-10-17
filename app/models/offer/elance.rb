class Offer::Elance
  require 'open-uri'

  API_URL = 'https://api.elance.com/'

  class << self
    def import_offers
      imported_offers = 0
      @access_token = get_access_token
      get_offers.each do |offer|
        offer.symbolize_keys!
        next if Offer.imported?(offer[:jobId], :elance)
        new_offer = Offer.create(
          title:     offer[:name],
          source:    Offer.source_id(:elance),
          desc:      get_desc(offer[:description]),
          posted_at: get_date(offer[:postedDate]),
          ext_id:    offer[:jobId],
          offer_url: offer[:jobURL]
        )
        imported_offers += 1 if new_offer.persisted?
      end
      imported_offers
    end

    private

    def get_access_token
      JSON.parse(request_access_token)['data']['access_token'] rescue ''
    end

    def request_access_token
      `curl -k -v -X POST #{API_URL}api2/oauth/token -d "client_id=#{ENV['ELANCE_CLIENT_ID']}&client_secret=#{ENV['ELANCE_CLIENT_SECRET']}&grant_type=client_credentials" --compressed`
    end

    def get_date(seconds)
      Time.at(seconds.to_i).to_date
    end

    def get_desc(desc)
      desc.gsub(/\(ID: [0-9]+\)$/, '')
    end

    def get_offers
      JSON.parse(fetch_offers)['data']['pageResults'] rescue []
    end

    def fetch_offers
      File.read(open("#{API_URL}api2/jobs?access_token=#{@access_token}"))
    end
  end

end