class Offer::Fl
  RSS_URL = "https://www.fl.ru/rss/all.xml"
  SOURCE_NAME = :fl

  private

  def self.import_offers
    RssImport.import_offers(self)
  end

  def self.get_ext_id(url)
    url.match(/projects\/([0-9]+)/)[1]
  end

end