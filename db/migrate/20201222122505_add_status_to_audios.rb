class AddStatusToAudios < ActiveRecord::Migration[6.0]
  def change
    add_column :audios, :status, :boolean, default: false
  end
end
