class AnnouncementsController < UnitContextController
  def index
    @announcements = @unit.messages
  end
end
