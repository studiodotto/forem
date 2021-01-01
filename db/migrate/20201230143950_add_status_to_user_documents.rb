class AddStatusToUserDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :user_documents, :status, :boolean, default: false
  end
end
