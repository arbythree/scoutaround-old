class AddCharteringOrganizationFieldsToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :chartering_organization_name, :string
    add_column :units, :chartering_organization_representatie_id, :integer
    add_column :units, :charter_expires_at, :date
  end
end
