class EventPresenter < BasePresenter
  presents :event

  def dates
    # crosses year boundary
    if event.starts_at.year != event.ends_at.year
      raw([
        event.starts_at.strftime('%B %-d, %Y'),
        '&ndash;',
        event.ends_at.strftime('%B %-d, %Y')
      ].join)

    # crosses month boundary
    elsif event.starts_at.month != event.ends_at.month
      raw([
        event.starts_at.strftime('%B %-d'),
        '&ndash;',
        event.ends_at.strftime('%B %-d, %Y')
      ].join)

    # multi-day, same month
    elsif event.starts_at.day != event.ends_at.day
      raw([
        event.starts_at.strftime('%B %-d'),
        '&ndash;',
        event.ends_at.strftime('%-d, %Y')
      ].join)

    # single day with times
    elsif event.starts_at.hour > 0 && event.ends_at.hour > 0
      raw(
        event.starts_at.strftime('%B %-d, %Y %l:%M %p') +
        '&ndash;' +
        event.ends_at.strftime('%l:%M %p')
      )
      
    # single day
    else
      event.starts_at.strftime('%B %-d, %Y')
    end
  end
end
