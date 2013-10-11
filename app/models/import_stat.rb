class ImportStat < ActiveRecord::Base
  class << self

    def check_sources(limit = 10)
      Offer::SOURCES.each do |source|
        check_source(source, limit)
      end
      true
    end

    def check_source(source, limit = 10)
      puts
      puts '-' * 20
      puts source.upcase
      where(source: Offer.source_id(source)).limit(limit).order(created_at: :desc).map do |import|
        puts "#{import.created_at.strftime('%H:%M')} => #{import.imported}"
      end
      true
    end

    def delete_old!
      where("created_at <= ?", 1.month.ago).destroy_all
    end

  end
end