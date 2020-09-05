class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || get_locale_from_http_header || I18n.default_locale
  end

  def get_locale_from_http_header
    I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
  end

  # Automatically add locale parameter to every url_for helper
  def default_url_options
    { locale: I18n.locale }
  end

end
