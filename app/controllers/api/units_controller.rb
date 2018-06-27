class Api::UnitsController < Api::ApiController
  before_action :find_unit

  def show
    render json: @unit
  end

  def update
    @unit.assign_attributes(unit_params)

    if @unit.save
      render json: @unit, status: :ok
    else
    end
  end

  private

  def find_unit
    @unit = Unit.find(params[:id])
  end

  def unit_params
    params.require(:unit).permit(:expires_at)
  end
end
