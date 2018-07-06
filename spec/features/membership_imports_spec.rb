require 'rails_helper'

RSpec.feature "Membership imports features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
  end

  it 'visits the import page' do
    visit new_unit_membership_import_path(@unit)
    expect(page).to have_current_path(new_unit_membership_import_path(@unit))
  end
end
