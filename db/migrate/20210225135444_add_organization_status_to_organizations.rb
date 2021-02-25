class AddOrganizationStatusToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :status, :string, default: 'pending'
  end
end
