class EventType
  attr_accessor :id
  attr_accessor :name

  class << self
    attr_accessor :unit
  end

  def initialize(args)
    self.id = args[:id]
    self.name = args[:name]
  end

  def self.all
    [
      EventType.new(id: 'UnitMeeting',       name: "#{ unit.type } Meeting"),
      EventType.new(id: 'Camping',           name: 'Camping'),
      EventType.new(id: 'Community Service', name: 'CommunityService'),
      EventType.new(id: 'Eagle Project',     name: 'EagleProject'),
    ]
  end
end
