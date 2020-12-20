class AddGoogleKeysToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :google_created_at, :datetime
    add_column :users, :google_url, :string
  end
end
