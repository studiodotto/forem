class AddBankAccountToUserDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :user_documents, :bank_account, :string
  end
end
