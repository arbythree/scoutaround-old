class AddCouncilAndDistrictToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :council, :string
    add_column :units, :district, :string
  end
end
