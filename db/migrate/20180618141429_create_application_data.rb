class CreateApplicationData < ActiveRecord::Migration[5.2]
  def change
    create_table :application_data do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
