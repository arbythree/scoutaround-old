class UnitPositionsController < AuthenticatedController
  before_action :find_unit_position, except: [:index, :create]

  def index
    authorize UnitPosition
    @unit_positions = @unit.unit_positions
  end

  def create
    @unit_position = @unit.unit_positions.new(unit_position_params)
    if @unit_position.save!
      flash[:notice] = 'Added new position'
      redirect_to unit_unit_positions_path(@unit)
    end
  end

  def destroy
    authorize @unit_position
    unit = @unit_position.unit

    # whack it!
    if @unit_position.destroy
      unit.memberships.where(unit_position_id: @unit_position.id).update_all(unit_position_id: nil)
      flash[:notice] = 'Removed position'
      redirect_to unit_unit_positions_path(unit)
    else
      flash[:error] = @unit_position.errors[:base].first
      redirect_to unit_unit_positions_path(unit)
    end
  end

  private

  def find_unit_position
    @unit_position = UnitPosition.includes(:membership).find(params[:id])
  end

  def unit_position_params
    params.require(:unit_position).permit(:name, :audience)
  end
end
