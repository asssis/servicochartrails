Rails.application.routes.draw do
  resources :sales
  resources :products

  get '/sale/pesquisa', to: 'sales#pesquisa'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
