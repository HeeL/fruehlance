class OdeskOffer

  API_URL = 'https://www.odesk.com/'
  OFFERS_PATH = 'api/profiles/v1/search/jobs.json'

  def self.get_offers
    JSON.parse(fetch_offers).symbolize_keys rescue {}
  end

  private

  def self.fetch_offers
    fetch_path(OFFERS_PATH)
  end

  def self.fetch_path(path)
    `curl #{API_URL}#{path}`
  end

end