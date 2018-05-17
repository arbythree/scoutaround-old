class CreateGuardianships < ActiveRecord::Migration[5.1]
  def change
    create_table :guardianships do |t|
      t.integer :guardian_id
      t.integer :guardee_id

      t.timestamps
    end

    execute('ALTER SEQUENCE guardianships_id_seq RESTART WITH 30193')
  end
end
