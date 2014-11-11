ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  def select_date_and_time(date, options = {})
    field = options[:from]
    select date.strftime('%Y'), from: "#{field}_1i" #year
    select date.strftime('%B'), from: "#{field}_2i" #month
    select date.strftime('%d'), from: "#{field}_3i" #day 
    select date.strftime('%H'), from: "#{field}_4i" #hour
    select date.strftime('%M'), from: "#{field}_5i" #minute
  end

  def log_in
    visit '/parkings'
    click_link 'Log in'
    fill_in 'email', with: 'steve@jobs.com'
    click_button 'Log in'
  end
end
