class AddStatusToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :status, :boolean, default: false
  end
end
