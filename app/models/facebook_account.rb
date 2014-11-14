class FacebookAccount < ActiveRecord::Base
  validates :uid, :person, presence: true

  belongs_to :person

  accepts_nested_attributes_for :person

  def self.find_or_create_for_facebook(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |facebook_account|
      facebook_account.provider = auth.provider
      facebook_account.uid = auth.uid
      facebook_account.build_person(first_name: auth.info.name)
    end
  end

  private
  def facebook_account_params
    params.require(:facebook_account).permit(:uid, :provider, :person)
  end
end

