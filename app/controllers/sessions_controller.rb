class SessionsController < ApplicationController

  def new
    @no_header = true
  end

  def create
    if auth_hash.present? && auth_hash.has_key?(:uid)
      person = FacebookAccount.find_or_create_for_facebook(auth_hash)
    else
      person = Account.authenticate(params[:email], params[:password])
    end

    if person
      session[:person_id] = person.id
      redirect_to return_to_path, notice: "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:person_id] = nil
    redirect_to parkings_path, notice: "Logged out!"
  end

  def failure
    redirect_to parkings_path, alert: "Authentication failed."
  end

  private
  def return_to_path
    session.delete(:return_to) || root_path
  end

  def auth_hash
    request.env["omniauth.auth"]
  end
end
