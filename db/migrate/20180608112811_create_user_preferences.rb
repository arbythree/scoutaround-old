class CreateUserPreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :user_preferences do |t|
      t.integer :user_id
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
