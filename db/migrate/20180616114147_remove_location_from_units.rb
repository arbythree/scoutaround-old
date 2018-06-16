class RemoveLocationFromUnits < ActiveRecord::Migration[5.2]
  def change
    remove_column :units, :location
  end
end
