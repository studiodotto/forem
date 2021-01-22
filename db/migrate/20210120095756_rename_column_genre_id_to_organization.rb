class RenameColumnGenreIdToOrganization < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      remove_column :organizations, :genre_id
      add_column :organizations, :genre_id, :string
    end
  end
end
