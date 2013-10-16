#encoding: utf-8

class Offer::Freelansim
  require 'open-uri'

  URL = "http://freelansim.ru/"

  class << self
    def import_offers(pages = 3)
      imported_offers = 0
      (1..pages).each do |page_num|
        Nokogiri::HTML(open(offer_list_url(page_num))).css('.task').each do |offer|
          @offer = offer
          ext_id = get_ext_id
          next if Offer.imported?(ext_id, :freelansim)
          new_offer = Offer.create(
            title:     get_title,
            source:    Offer.source_id(:freelansim),
            desc:      get_desc,
            posted_at: get_date,
            ext_id:    ext_id,
            offer_url: offer_url(ext_id)
          )
          imported_offers += 1 if new_offer.persisted?
        end
      end
      imported_offers
    end

    private

    def offer_list_url(page = 1)
      "#{URL}tasks?page=#{page}"
    end

    def get_title
      @offer.css('.title a').text()
    end

    def get_desc
      @offer.css('.description').text()
    end

    def get_date      
      translate_date(@offer.css('.published').text())
    end

    def get_ext_id
      @offer.css('.title a').first[:href].match(/\/tasks\/([0-9]+)/)[1] rescue false
    end

    def offer_url(id)
      "#{URL}tasks/#{id}"
    end

    def translate_date(ru_date)
      if ru_date.match(/(час|минут)/i)
        Date.today
      elsif ru_date.match(/([0-9]+) (день|дня|дней)/i)
        Date.today - $1.to_i
      else
        false
      end
    end

  end

end