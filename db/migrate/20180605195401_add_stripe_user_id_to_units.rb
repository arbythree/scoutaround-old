class AddStripeUserIdToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :stripe_user_id, :string
  end
end
