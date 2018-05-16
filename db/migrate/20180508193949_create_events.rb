class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :unit_id
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :location

      t.timestamps
    end
  end
end
