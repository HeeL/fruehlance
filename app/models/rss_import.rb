include ActionView::Helpers::SanitizeHelper

class RssImport

  def self.import_offers(klass)
    imported_offers = 0
    feed = Feedzirra::Feed.fetch_and_parse(klass::RSS_URL)
    feed.entries.each do |offer|
      ext_id = klass::get_ext_id(offer.url)
      next if Offer.imported?(ext_id, klass::SOURCE_NAME)
      new_offer = Offer.create(
        title:     offer.title,
        source:    Offer.source_id(klass::SOURCE_NAME),
        desc:      replace_tags(offer.summary),
        posted_at: offer.published,
        ext_id:    ext_id,
        offer_url: offer.url
      )
      imported_offers += 1 if new_offer.persisted?
    end
    imported_offers
  end

  private

  def self.replace_tags(text)
    text.gsub!(/\<\/(p|li)\>/, "\n")
    text.gsub!(/\<br[\s]*\>/, "\n")
    strip_tags(text)
  end

end