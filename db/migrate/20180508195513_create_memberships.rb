class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :unit_id
      t.boolean :active, default: true
      t.integer :role

      t.timestamps
    end
  end
end
