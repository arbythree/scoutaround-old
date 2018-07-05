class AddCcFieldsToEventSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :event_submissions, :cc_last_4, :string
    add_column :event_submissions, :cc_expiration_month, :string
    add_column :event_submissions, :cc_expiration_year,  :string
  end
end
