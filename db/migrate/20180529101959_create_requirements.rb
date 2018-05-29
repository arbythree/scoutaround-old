class CreateRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :requirements do |t|
      t.string  :type
      t.string  :description
      t.integer :achievable_id
      t.integer :required_id
      t.string  :parameter
      t.string  :program_code
      t.integer :precursor_id

      t.timestamps
    end
  end
end
