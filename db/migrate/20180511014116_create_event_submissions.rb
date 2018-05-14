class CreateEventSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :event_submissions do |t|
      t.integer :event_requirement_id
      t.integer :submitter_id
      t.integer :approver_id
      t.datetime :approved_at
      t.integer :registration_id

      t.timestamps
    end
  end
end
