Fruehlance::Application.routes.draw do

  root 'offers#index'

  get '/offers/search' => 'offers#search', as: :offers_search

end
