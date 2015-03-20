Rails.application.routes.draw do
  root to: 'logs#index'
  get '/rooms/:room' => 'rooms#show'
  get '/logs/search' => 'logs#search'
end
