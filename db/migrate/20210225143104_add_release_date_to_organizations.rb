class AddReleaseDateToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :release_date, :date
  end
end
