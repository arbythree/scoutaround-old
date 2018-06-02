class AddEarnedAtToAchievements < ActiveRecord::Migration[5.2]
  def change
    add_column :achievements, :earned_at, :date
  end
end
