class CreateProjectEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :project_events do |t|
      t.string :title
      t.string :icon
      t.string :organization_id
      t.string :type
      t.timestamps
    end
  end
end
