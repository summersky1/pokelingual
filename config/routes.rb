Rails.application.routes.draw do
  root to: 'pokemon#home'
  get 'pokemon', to: 'pokemon#home'
  get 'pokemon/:id', to: 'pokemon#show'
end
