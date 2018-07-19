class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :external_id
      t.integer :amount
      t.string :brand
      t.string :last4
      t.integer :expiration_month
      t.integer :expiration_year

      t.timestamps
    end

    add_column :event_submissions, :payment_id, :integer
  end
end
