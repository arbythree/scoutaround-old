class AddProgramCodeToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :program_code, :string
  end
end
