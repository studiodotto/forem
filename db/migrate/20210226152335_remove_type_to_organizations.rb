class RemoveTypeToOrganizations < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      remove_column :organizations, :type
    end
  end
end
