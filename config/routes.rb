Rails.application.routes.draw do
  scope '/:locale' do
    get 'search', to: 'pokemon#search'
    get 'pokemon/:id', to: 'pokemon#show'
    get 'generation/:id', to: 'pokemon#generation'
    # only used for JSON autocomplete suggestions
    get 'autocomplete', to: 'pokemon#autocomplete'
    get "*path" => redirect("/")
  end

  root to: redirect("/#{I18n.locale}/search", status: 302), as: :redirected_root
  # always redirect urls without locale
  get "/*path", to: redirect("/#{I18n.locale}/%{path}", status: 302)
end
