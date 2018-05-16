class CreateRegistrations < ActiveRecord::Migration[5.1]
  def change
    create_table :event_registrations do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
