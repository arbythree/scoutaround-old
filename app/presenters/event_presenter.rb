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

    # single day with all AM or all PM times
    elsif event.starts_at.hour > 0 && event.ends_at.hour > 0 && (event.starts_at.strftime('%p') == event.ends_at.strftime('%p'))
      raw([
        '<span class="date">',
        event.starts_at.strftime('%B %-d, %Y'),
        '</span>',
        '&nbsp;',
        '&nbsp;',
        '&nbsp;',
        '&nbsp;',
        '<span class="times">',
        event.starts_at.strftime('%-I:%M'),
        '&ndash;',
        event.ends_at.strftime('%-I:%M %p'),
        '</span>',
      ].join)

    # single day with AM and PM times
    elsif event.starts_at.hour > 0 && event.ends_at.hour > 0
      raw("#{event.starts_at.strftime('%B %-d, %Y %-I:%M %p')}&ndash;#{event.ends_at.strftime('%-I:%M %p')}")

    # single all-day
    else
      event.starts_at.strftime('%B %-d, %Y')
    end
  end

  def times
    if event.all_day?
      ''
    elsif event.starts_at.strftime('%p') == event.ends_at.strftime('%p')
      raw([
        event.starts_at.strftime('%-I:%M'),
        '&ndash;',
        event.ends_at.strftime('%-I:%M %p'),
      ].join)

    # single day with AM and PM times
    else event.starts_at.hour > 0 && event.ends_at.hour > 0
      raw("#{event.starts_at.strftime('%-I:%M %p')}&ndash;#{event.ends_at.strftime('%-I:%M %p')}")
    end
  end
end
