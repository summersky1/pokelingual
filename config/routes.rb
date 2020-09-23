Rails.application.routes.draw do

  scope '/:locale' do
    get 'search', to: 'pokemon#search'
    get 'pokemon/:id', to: 'pokemon#show'
    get 'generation/:id', to: 'pokemon#generation'
    get 'about', to: 'pokemon#about'
    # only used for JSON autocomplete suggestions
    get 'autocomplete', to: 'pokemon#autocomplete'
  end

  root to: "pokemon#search"
  # redirect invalid locations to root
  get "/*path", to: redirect("/", status: 302)
  
end
