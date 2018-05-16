class HomeController < AuthenticatedController
  def index
    unless @current_user.multiple_units?
      redirect_to unit_events_path(unit_id: @current_user.units.first.id)
    end
  end
end
