class CreateAchievables < ActiveRecord::Migration[5.2]
  def change
    create_table :achievables do |t|
      t.string :name
      t.string :type
      t.string :program_code

      t.timestamps
    end
  end
end
