class AnnouncementsController < UnitContextController
  def index
    @messages = @unit.messages
  end
end
