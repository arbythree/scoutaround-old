class CreateAchievements < ActiveRecord::Migration[5.2]
  def change
    create_table :achievements do |t|
      t.integer :user_id
      t.integer :achievable_id

      t.timestamps
    end
  end
end
