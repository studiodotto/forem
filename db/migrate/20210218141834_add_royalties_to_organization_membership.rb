class AddRoyaltiesToOrganizationMembership < ActiveRecord::Migration[6.0]
  def change
    add_column :organization_memberships, :royalty, :float, default: 0
  end
end
