class AddVerifiedStatusToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_verified, :boolean, default: true
  end
end
