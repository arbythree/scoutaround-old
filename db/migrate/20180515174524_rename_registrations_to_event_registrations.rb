class RenameRegistrationsToEventRegistrations < ActiveRecord::Migration[5.1]
  def change
    rename_table :registrations, :event_registrations
  end
end
