class ChangeUserIdNullToFalse < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!
  def change
    safety_assured do
      change_column :organization_memberships, :user_id, :integer, :null => true
    end
  end
end
