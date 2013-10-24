class Offer::Weblancer
  RSS_URL = "http://www.weblancer.net/rss/projects.rss"
  SOURCE_NAME = :weblancer

  private

  def self.import_offers
    RssImport.import_offers(self)
  end

  def self.get_ext_id(url)
    url.match(/projects\/([0-9]+)/)[1]
  end

end