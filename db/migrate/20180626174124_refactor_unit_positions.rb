class RefactorUnitPositions < ActiveRecord::Migration[5.2]
  def change
    remove_column :unit_positions, :program_code
    add_column :unit_positions, :unit_id, :integer
  end
end
