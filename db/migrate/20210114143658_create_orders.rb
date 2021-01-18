class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.timestamp :delivery_date
      t.integer :organization_id
      t.string :status
      t.float :total_amount
      t.string :credits_count
      t.string :language
      t.text :instruction
      t.string :email
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :release_id
      t.string :event_type
      t.string :order_type
      t.timestamps
    end
  end
end
