Fruehlance::Application.routes.draw do

  root 'offers#index'

  get '/offers/search' => 'offers#search', as: :offers_search

  get '/stats' => 'stats#index', as: :stats
  get '/stats/hourly_stats' => 'stats#hourly_stats', as: :hourly_stats
  get '/stats/daily_stats' => 'stats#daily_stats', as: :daily_stats
  get '/stats/last_days_stats' => 'stats#last_days_stats', as: :last_days_stats

end
