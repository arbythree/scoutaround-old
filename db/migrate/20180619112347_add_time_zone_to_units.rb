class AddTimeZoneToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :time_zone, :string
  end
end
