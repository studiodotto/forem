class AddSlugToAudios < ActiveRecord::Migration[6.0]
  def change
    add_column :audios, :slug, :string
  end
end
