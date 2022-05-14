Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#  root to: "home#index"
#  resources :search
  root to: 'search#index'
  get '/boblio/', to: 'search#index'
  get '/boblio/:id', to: 'search#show', as: "detail"
  get '/boblio/designer/:id', to: 'search#designer', as: "designer"
end
