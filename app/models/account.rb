class Account < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  has_secure_password validations: false
  validates :password, presence: true, confirmation: true

  belongs_to :person

  accepts_nested_attributes_for :person

  def self.authenticate(email, password)
    account = Account.find_by_email(email)
    account.authenticate(password) if account
  end
end

