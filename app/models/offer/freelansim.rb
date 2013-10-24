class Offer::Freelansim
  RSS_URL = "http://freelansim.ru/rss/tasks"
  SOURCE_NAME = :freelansim

  private

  def self.import_offers
    RssImport.import_offers(self)
  end

  def self.get_ext_id(url)
    url.split('/').last
  end

end