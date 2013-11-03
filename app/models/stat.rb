class Stat

  def self.hourly_stats
    offers = Offer.where("source IN (?) AND created_at BETWEEN ? AND ?", Offer.ru_sources, 14.days.ago.beginning_of_day, 1.day.ago.end_of_day)
    source_hours = {}
    offers.each do |offer|
      source_hours[offer.source_name] ||= Array.new(24, 0)
      hour = offer.created_at.strftime('%k').to_i
      source_hours[offer.source_name][hour] ||= 0
      source_hours[offer.source_name][hour] += 1
    end
    source_hours.map{|source, data| data.map!{|value| (value / 14.0).ceil}}
    source_hours
  end

end