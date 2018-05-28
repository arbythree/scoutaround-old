class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :author_id
      t.text    :body
      t.string  :messagable_type
      t.integer :messagable_id

      t.timestamps
    end
  end
end
