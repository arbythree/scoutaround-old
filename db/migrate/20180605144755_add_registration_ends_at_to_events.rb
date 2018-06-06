class AddRegistrationEndsAtToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :registration_closes_at, :datetime
    add_column :event_submissions, :due_at, :datetime
  end
end
