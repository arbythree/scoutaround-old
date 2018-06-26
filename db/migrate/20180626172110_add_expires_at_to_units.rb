class AddExpiresAtToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :subscription_expires_at, :date
  end
end
