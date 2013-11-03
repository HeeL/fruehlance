Fruehlance::Application.routes.draw do

  root 'offers#index'

  get '/offers/search' => 'offers#search', as: :offers_search
  get '/stats' => 'stats#index', as: :stats
  get '/stats/hourly_stats' => 'stats#hourly_stats', as: :hourly_stats

end
