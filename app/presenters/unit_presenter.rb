class UnitPresenter < BasePresenter
  presents :unit

  def display_name
    "#{I18n.t("units.#{unit.type.downcase}")} #{unit.number}"
  end
end
