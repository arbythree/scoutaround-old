class MembersController < AuthenticatedController
  before_action :find_unit

  def index
    @members = @unit.members
  end

  private

  def find_unit
    @unit = @current_person.units.find(params[:unit_id])
  end
end
