class RefactorFeeRequirementSchema < ActiveRecord::Migration[5.2]
  def change
    rename_column :event_requirements, :amount, :amount_youth
    change_column :event_requirements, :amount_youth, :integer
    add_column :event_requirements, :amount_adult, :integer
    add_column :event_submissions, :stripe_charge_id, :string
  end
end
