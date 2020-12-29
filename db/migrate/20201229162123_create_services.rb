class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :name
      t.float :price
      t.string :currency
      t.references :artist_application, null: false, foreign_key: true
      t.integer :user_id, null: true
      t.timestamps
    end
  end
end
