class CreatePrototypePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :prototype_positions do |t|
      t.string :program_code
      t.string :audience
      t.string :name

      t.timestamps
    end
  end
end
