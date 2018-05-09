class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.integer :person_id
      t.integer :unit_id

      t.timestamps
    end
  end
end
