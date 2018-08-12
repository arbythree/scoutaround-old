class AddApprovedByToAchievements < ActiveRecord::Migration[5.2]
  def change
    add_column :achievements, :approved_by, :string
  end
end
