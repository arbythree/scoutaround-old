class HomeController < AuthenticatedController
  def index
    @current_user = current_user
    @current_person = current_user.person

    unless @current_person.multiple_units?
      redirect_to unit_events_path(unit_id: @current_person.units.first.id)
    end
  end
end
