class CreateUnitPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_positions do |t|
      t.string :program_code
      t.string :audience
      t.string :name

      t.timestamps
    end
  end
end
