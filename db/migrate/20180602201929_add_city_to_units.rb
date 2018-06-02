class AddCityToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :city, :string
  end
end
