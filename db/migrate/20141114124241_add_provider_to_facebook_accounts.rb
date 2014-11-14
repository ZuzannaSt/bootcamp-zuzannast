class AddProviderToFacebookAccounts < ActiveRecord::Migration
  def change
    add_column :facebook_accounts, :provider, :string
  end
end
