class AddCollaboratorToOrganizationMembership < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!
  def change
    add_column :organization_memberships, :collaborator_id, :integer
    add_index :organization_memberships, %i[collaborator_id organization_id], unique: true, algorithm: :concurrently, name: :idx_org_artist_user
  end
end
