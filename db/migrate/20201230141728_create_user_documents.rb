class CreateUserDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_documents do |t|
      t.string :government_id
      t.string :card_last_4
      t.string :exp_year
      t.string :exp_month
      t.string :cvc
      t.string :iban_number
      t.string :ethereum_address
      t.string :bitcoin_address
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
