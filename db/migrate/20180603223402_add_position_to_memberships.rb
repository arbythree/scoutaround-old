class AddPositionToMemberships < ActiveRecord::Migration[5.2]
  def change
    add_column :memberships, :unit_position_id, :integer
    add_column :memberships, :notes, :text
  end
end
