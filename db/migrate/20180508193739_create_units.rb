class CreateUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :units do |t|
      t.string :type
      t.string :number
      t.string :location

      t.timestamps
    end
  end
end
