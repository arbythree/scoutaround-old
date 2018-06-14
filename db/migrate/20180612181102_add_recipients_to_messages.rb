class AddRecipientsToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :pingees, :string
  end
end
