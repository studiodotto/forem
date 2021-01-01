class CreatePaymentProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_providers do |t|
      t.string :external_id
      t.string :access_token
      t.string :refresh_token
      t.string :descriptor
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
