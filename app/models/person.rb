class Person < ActiveRecord::Base
  validates :first_name, presence: true

  has_many :parkings, foreign_key: "owner_id"
  has_many :cars, foreign_key: "owner_id"

  def full_name
    if last_name.blank?
      self.first_name
    else
      "#{self.first_name} #{self.last_name}"
    end
  end

  def self.authenticate(email, password)
    account = Account.find_by_email(email)
    if account && account.password_digest == BCrypt::Engine.hash_secret(password, account.password_digest)
      account.person
    else
      nil
    end
  end
end
