class AddWaiveTransactionFeesToEventRequirements < ActiveRecord::Migration[5.2]
  def change
    add_column :event_requirements, :waive_transaction_fees, :boolean, default: false
  end
end
