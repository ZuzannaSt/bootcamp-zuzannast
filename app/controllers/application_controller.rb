class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :page_title
  helper_method :current_person

  def page_title
    controller_name
  end

  def current_person
    @current_person ||= Person.find(session[:person_id]) if session[:person_id]
  end
end
