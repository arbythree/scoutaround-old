class AddEmailAndPhoneToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :email, :string
    add_column :people, :phone, :string
  end
end
