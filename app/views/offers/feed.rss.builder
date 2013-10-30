xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Frühlance"
    xml.description "Fruehlance.com - aggregator of freelance jobs"
    xml.link url_for(params.merge(format: '', only_path: false))

    for offer in @offers
      xml.item do
        xml.title offer.title
        xml.description "#{offer.source_display_name}:\n\n #{offer.desc}"
        xml.pubDate offer.posted_at.to_s(:rfc822)
        xml.link offer.offer_url
        xml.guid offer.offer_url
      end
    end
  end
end