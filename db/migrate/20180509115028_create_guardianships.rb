class CreateGuardianships < ActiveRecord::Migration[5.1]
  def change
    create_table :guardianships do |t|
      t.integer :guardian_id
      t.integer :guardee_id

      t.timestamps
    end
  end
end
