class AddStatusToArtistApplications < ActiveRecord::Migration[6.0]
  def change
    add_column :artist_applications, :status, :boolean, default: false
  end
end
