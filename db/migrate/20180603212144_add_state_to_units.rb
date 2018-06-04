class AddStateToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :state, :string
  end
end
