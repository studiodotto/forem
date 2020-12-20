class AddGoogleUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :google_username, :string
  end
end
