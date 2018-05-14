class AddRoleToMemberships < ActiveRecord::Migration[5.1]
  def change
    add_column :memberships, :role, :integer
  end
end
