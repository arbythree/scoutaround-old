class AddRequiredToEventRequirements < ActiveRecord::Migration[5.2]
  def change
    add_column :event_requirements, :required, :boolean, default: true
  end
end
