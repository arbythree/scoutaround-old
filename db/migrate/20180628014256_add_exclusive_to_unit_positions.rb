class AddExclusiveToUnitPositions < ActiveRecord::Migration[5.2]
  def change
    add_column :unit_positions, :exclusive, :boolean, default: true
    add_column :prototype_positions, :exclusive, :boolean, default: true
  end
end
