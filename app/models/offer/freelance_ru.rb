class Offer::FreelanceRu
  RSS_URL = "http://freelance.ru/rss/projects.xml"
  SOURCE_NAME = :freelance_ru

  private

  def self.import_offers
    RssImport.import_offers(self)
  end

  def self.get_ext_id(url)
    url.match(/projects\/([0-9]+)/)[1]
  end

end