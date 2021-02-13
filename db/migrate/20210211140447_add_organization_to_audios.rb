class AddOrganizationToAudios < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!
  def change
    add_column :audios, :organization_id, :integer
    add_index :audios, :organization_id, algorithm: :concurrently
  end
end
