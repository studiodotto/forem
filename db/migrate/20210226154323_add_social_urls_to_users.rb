class AddSocialUrlsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :twitter_url, :string
    add_column :users, :apple_music_url, :string
    add_column :users, :soundcloud_url, :string
  end
end
