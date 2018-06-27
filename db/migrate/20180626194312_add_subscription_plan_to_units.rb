class AddSubscriptionPlanToUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_plans do |t|
      t.string :display_name
      t.string :internal_name
      t.string :sku
      t.string :frequency
      t.integer :price
      t.boolean :available

      t.timestamps
    end
    add_column :units, :subscription_plan_id, :integer
  end
end
