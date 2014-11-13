class RegistrationMailer < ActionMailer::Base
  default from: "hello@bookparking.dev"
  
  def welcome_email(person)
    @person = person
    @url  = login_url(:host)
    mail(to: @person.account.email, subject: 'Welcome to Bookparking')
  end

  def default_url_options
    if Rails.env.production?
      { :host => "bootcamp-zustmust.herokuapp.com" }
    else
      { :host => "bookpark.dev" }
    end
  end
end
