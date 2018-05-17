class CreateEventRegistrations < ActiveRecord::Migration[5.1]
  def change
    create_table :event_registrations do |t|
      t.integer :event_id
      t.integer :user_id
      t.boolean :attended

      t.timestamps
    end

    execute('ALTER SEQUENCE event_registrations_id_seq RESTART WITH 66287')
  end
end
