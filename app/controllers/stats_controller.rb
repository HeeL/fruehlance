class StatsController < ApplicationController

  def index

  end

  def hourly_stats
    @hourly_stats = Stat.hourly_stats
  end

end
