class Stat

  STAT_DAYS = 10

  def self.hourly_stats
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

  private

  def self.sql_exec(sql)
    ActiveRecord::Base.connection.execute(sql)
  end

end