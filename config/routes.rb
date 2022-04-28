Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :search
  get '/search/designer/:id', to: 'search#designer', as: "designer"
end
