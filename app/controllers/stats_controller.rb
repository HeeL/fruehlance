class StatsController < ApplicationController

  def index
  end

  def hourly_stats
    @hourly_stats = Stat.hourly_stats
  end

  def daily_stats
    @daily_stats = Stat.daily_stats
  end

  def last_days_stats
    @last_days_stats = Stat.last_days_stats
  end

end
