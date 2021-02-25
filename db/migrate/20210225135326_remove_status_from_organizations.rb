class RemoveStatusFromOrganizations < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      remove_column :organizations, :status
    end
  end
end
