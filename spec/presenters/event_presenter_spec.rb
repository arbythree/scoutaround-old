require 'rails_helper'

describe EventPresenter do
  include ActionView::TestCase::Behavior

  it 'handles events that span year boundaries' do
    event = FactoryBot.build(:event, starts_at: '2018-12-27', ends_at: '2019-01-04')
    presenter = EventPresenter.new(event, view)
    expect(presenter.dates).to eq('December 27, 2018&ndash;January 4, 2019')
  end

  it 'handles events that span month boundaries' do
    event = FactoryBot.build(:event, starts_at: '2018-11-27', ends_at: '2018-12-04')
    presenter = EventPresenter.new(event, view)
    expect(presenter.dates).to eq('November 27&ndash;December 4, 2018')
  end

  it 'handles events that span day boundaries' do
    event = FactoryBot.build(:event, starts_at: '2018-11-27', ends_at: '2018-11-29')
    presenter = EventPresenter.new(event, view)
    expect(presenter.dates).to eq('November 27&ndash;29, 2018')
  end

  it 'handles single-day events' do
    event = FactoryBot.build(:event, starts_at: '2018-11-27', ends_at: '2018-11-27')
    presenter = EventPresenter.new(event, view)
    expect(presenter.dates).to eq('November 27, 2018')
  end
end
