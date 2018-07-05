class CreatePaymentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_methods do |t|
      t.integer :user_id
      t.string :last4
      t.integer :expiration_month
      t.integer :expiration_year
      t.string :brand
      t.string :stripe_id

      t.timestamps
    end
  end
end
