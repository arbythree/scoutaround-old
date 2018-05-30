class CreateAchievables < ActiveRecord::Migration[5.2]
  def change
    create_table :achievables do |t|
      t.string  :type
      t.string  :name
      t.string  :description
      t.string  :program_code
      t.integer :parent_achievable_id
      t.integer :requirable_id
      t.integer :param
      t.integer :precursor_id

      t.timestamps
    end
  end
end
