Rails.application.routes.draw do
  root to: 'logs#index'
  get '/rooms/:room' => 'rooms#show'
  get '/logs/search' => 'logs#search'

  if Rails.env.development?
    get '/assets/:path(*all)' => redirect('http://localhost:8080/assets/%{path}%{all}')
  end
end
