class UnitSettingsController < UnitContextController
  include UnitContext

  def index
    session[:unit_id] = @unit.id # kludge alert: the Stripe callback URL can't be dynamic, so we need to cache the unit we're setting up
  end

  def show
  end

  def edit
    authorize @unit.becomes(Unit)
    @body_classes = %w(admin)
    session[:unit_id] = @unit.id # kludge alert: the Stripe callback URL can't be dynamic, so we need to cache the unit we're setting up
  end

  def update
    authorize @unit.becomes(Unit)

    if @unit.update_attributes(unit_params)
      flash[:notice] = I18n.t('units.success_update')
      redirect_to unit_unit_settings_path(@unit)
    end
  end

  private

  def unit_params
    params.require(:unit).permit(:city, :state, :council, :district, :chartering_organization_name, :time_zone)
  end
end
