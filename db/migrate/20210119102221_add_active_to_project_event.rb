class AddActiveToProjectEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :project_events, :active, :boolean
    safety_assured{ rename_column :project_events, :type, :event_type}
  end
end
