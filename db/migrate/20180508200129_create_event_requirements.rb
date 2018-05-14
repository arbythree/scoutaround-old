class CreateEventRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :event_requirements do |t|
      t.integer :event_id
      t.string :type
      t.string :description
      t.decimal :amount, precision: 8, scale: 2

      t.timestamps
    end
  end
end
