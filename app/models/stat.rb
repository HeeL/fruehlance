class Stat

  STAT_DAYS = 14
  STAT_LAST_DAYS = 7

  class << self

    def hourly_stats
      sql = <<-SQL
        SELECT source, ROUND(count(*) / double precision '#{STAT_DAYS}') as average_offers, date_part('hour', created_at) as hour_time
        FROM offers 
        WHERE source IN (#{Offer.ru_sources.join(',')}) AND
          created_at  BETWEEN '#{STAT_DAYS.days.ago.beginning_of_day}' AND '#{1.day.ago.end_of_day}'
        GROUP BY source, date_part('hour', created_at)
      SQL
      hour_stats = {}
      sql_exec(sql).each do |row|
        hour_stats[row['source']] ||= Array.new(24, 0)
        hour_stats[row['source']][row['hour_time'].to_i] = row['average_offers'].to_i
      end
      hour_stats
    end

    def daily_stats
      sql = <<-SQL
        SELECT source, ROUND(count(*) / double precision '#{STAT_DAYS / 7}') as average_offers, date_part('dow', created_at) as day_num
        FROM offers 
        WHERE source IN (#{Offer.ru_sources.join(',')}) AND
          created_at  BETWEEN '#{STAT_DAYS.days.ago.beginning_of_day}' AND '#{1.day.ago.end_of_day}'
        GROUP BY source, date_part('dow', created_at)
      SQL
      day_stats = {}
      sql_exec(sql).each do |row|
        day_stats[row['source']] ||= Array.new(7, 0)
        day_num = row['day_num'] == '0' ? 6 : row['day_num'].to_i - 1
        day_stats[row['source']][day_num] = row['average_offers'].to_i
      end
      day_stats
    end

    def last_days_stats
      sql = <<-SQL
        SELECT source, count(*) as offers, date_part('day', created_at) as day_num FROM offers WHERE 
        source IN (#{Offer.ru_sources.join(',')}) AND
        created_at BETWEEN '#{STAT_LAST_DAYS.days.ago.beginning_of_day}' AND '#{1.day.ago.end_of_day}'
        GROUP BY source, date_part('day', created_at)
      SQL
      day_stats = {}
      sql_exec(sql).each do |row|
        day_stats[row['source']] ||= {}
        day_stats[row['source']][timestamp_from_day(row['day_num'])] = row['offers'].to_i
      end
      sort_by_days(day_stats)
    end

    private

    def sql_exec(sql)
      ActiveRecord::Base.connection.execute(sql)
    end

    def sort_by_days(day_stats)
      #day_stats.each{|source, data| data.sort!{|x,y| y<=>x}}
    end

    def timestamp_from_day(day_num)
      (1..STAT_LAST_DAYS).each do |day|
        return day.days.ago.to_i if day.days.ago.strftime('%e').lstrip == day_num
      end
    end
  end

end