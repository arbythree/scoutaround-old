class AddAudienceToEventRequirements < ActiveRecord::Migration[5.2]
  def change
    add_column :event_requirements, :audience, :integer, default: 0
  end
end
