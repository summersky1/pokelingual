Rails.application.routes.draw do
  scope '/:locale' do
    root to: 'pokemon#home'
    get 'pokemon', to: 'pokemon#home'
    get 'pokemon/:id', to: 'pokemon#show'
  end

  # always redirect urls without locale
  root to: redirect("/#{I18n.locale}", status: 302), as: :redirected_root
  get "/*path", to: redirect("/#{I18n.locale}/%{path}", status: 302)
end
