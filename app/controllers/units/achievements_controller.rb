# achievements controller for the unit

class Units::AchievementsController < UnitContextController
  def index
    @view = params[:view] || 'roster'
  end
end
