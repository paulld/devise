Rails.application.routes.draw do
  
  devise_for :users

  root 'static_pages#index'
  
  get   '/users/'                                   => 'users#index'
  get   'edit'                                      => 'users#edit'
  patch 'edit'                                      => 'users#update'
  get   '/users/:id'                                => 'users#show',      as: 'user_show'


  get   '/companies'                                => 'companies#index', as: 'companies'
  get   '/companies/:stock_exchange'                => 'companies#index'
  get   '/companies/:stock_exchange/:symbol'        => 'companies#show',  as: 'company'

  get   '/airlines'                                 => 'airlines#index',  as: 'airlines'
  get   '/airlines/:icao'                           => 'airlines#show',   as: 'airline'

  get   '/airplanes'                                => 'airplanes#index', as: 'airplanes'
  get   '/airplanes/:airline_iata/:registration_code' => 'airplanes#show',  as: 'airplane'

  end
