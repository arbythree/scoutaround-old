class RenameSubmissionRegistrationIdToEventRegistrationId < ActiveRecord::Migration[5.1]
  def change
    rename_column :event_submissions, :registration_id, :event_registration_id
  end
end
