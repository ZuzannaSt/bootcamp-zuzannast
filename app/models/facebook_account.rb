class FacebookAccount < ActiveRecord::Base
  validates :uid, :person, presence: true

  belongs_to :person

  accepts_nested_attributes_for :person

  def self.find_or_create_for_facebook(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |person|
      person.provider = auth.provider
      person.uid = auth.uid
      person.name = auth.info.name
      person.oauth_token = auth.credentials.token
      person.oauth_expires_at = Time.at(auth.credentials.expires_at)
      person.save!
    end
  end
end

