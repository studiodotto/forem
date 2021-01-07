class AddUsertoArtistApplicatiion < ActiveRecord::Migration[6.0]
  def change
    add_column :artist_applications, :user_id, :integer
  end
end
