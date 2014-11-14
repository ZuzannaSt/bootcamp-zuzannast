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
    I18n.locale = params[:locale] || I18n.default_locale
    self.default_url_options = { locale: I18n.locale }
  end
end
