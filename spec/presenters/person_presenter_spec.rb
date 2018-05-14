require 'rails_helper'

RSpec.describe PersonPresenter do
  include ActionView::TestCase::Behavior

  it 'shows a full name' do
    person = FactoryBot.build(:person)
    presenter = PersonPresenter.new(person, view)
    expect(presenter.display_name).to eq("#{person.first_name} #{person.last_name}")
  end
end
