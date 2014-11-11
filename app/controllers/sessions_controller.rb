class SessionsController < ApplicationController

  def new
  end

  def create
    person = Person.authenticate(params[:email])
    if person
      session[:person_id] = person.id
      redirect_to parkings_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email"
      render "new"
    end
  end
end
