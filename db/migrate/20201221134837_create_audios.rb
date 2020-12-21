class CreateAudios < ActiveRecord::Migration[6.0]
  def change
    create_table :audios do |t|
      t.string :name
      t.string :link
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
