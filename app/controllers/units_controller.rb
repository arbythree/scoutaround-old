class UnitsController < UnitContextController
  def show
    @upcoming_events = @unit.events.upcoming
  end

  def edit
    authorize @unit.becomes(Unit)
  end

  def update
    authorize @unit.becomes(Unit)

    if @unit.update_attributes(unit_params)
      flash[:notice] = I18n.t('units.success_update')
      redirect_to unit_path(@unit)
    end
  end

  private

  def unit_params
    params.require(:unit).permit(:city, :state, :chartering_organization_name)
  end
end
