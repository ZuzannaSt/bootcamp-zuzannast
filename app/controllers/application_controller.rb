class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :page_title
  helper_method :current_person
  before_action :set_locale

  def page_title
    controller_name
  end

  def current_person
    @current_person ||= Person.find(session[:person_id]) if session[:person_id]
  end

  def authenticate_person
    unless current_person
      flash[:error] = "You must be logged in to access this section."
      session[:return_to] = request.original_url if request.get?
      redirect_to login_path
    end
  end

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header
  end

  def default_url_options(options = {})
    { locale: I18n.locale }
  end

  def extract_locale_from_accept_language_header
    if request.env['HTTP_ACCEPT_LANGUAGE'].present?
      browser_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end

    if I18n.available_locales.include? browser_locale
      browser_locale
    else
      I18n.default_locale
    end
  end
end
