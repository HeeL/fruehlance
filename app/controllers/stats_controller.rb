class StatsController < ApplicationController

  def index

  end

  def hourly_stats
    @hourly_stats = Stat.hourly_stats
  end

  def daily_stats
    @daily_stats = Stat.daily_stats
  end

end
