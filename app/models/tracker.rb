class Tracker
  event_events_index = 'events_index'

  def self.track(user: nil, event_name: nil, properties: nil)
    tracker = Mixpanel::Tracker.new(ENV['MIXPANEL_TOKEN'])
    tracker.track(user.id, event_name, properties || {})
  end
end
