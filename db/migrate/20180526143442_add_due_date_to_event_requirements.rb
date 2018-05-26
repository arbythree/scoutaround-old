class AddDueDateToEventRequirements < ActiveRecord::Migration[5.2]
  def change
    add_column :event_requirements, :due_at, :date
  end
end
