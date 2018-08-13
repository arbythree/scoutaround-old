class AddAwardedAtToAchievements < ActiveRecord::Migration[5.2]
  def change
    add_column :achievements, :awarded_at, :date
  end
end
