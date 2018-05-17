class CreateEventSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :event_submissions do |t|
      t.integer :event_requirement_id
      t.integer :event_registration_id
      t.integer :submitter_id
      t.integer :approver_id
      t.datetime :approved_at
      t.text :file_data

      t.timestamps
    end

    execute('ALTER SEQUENCE event_submissions_id_seq RESTART WITH 72830')
  end
end
