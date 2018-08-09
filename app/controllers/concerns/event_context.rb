module EventContext
  extend ActiveSupport::Concern

  included do
    before_action :find_event
    # before_action :find_unit
  end

  def find_event
    @event = Event.find(params[:event_id])
  end
end
