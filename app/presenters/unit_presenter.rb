class UnitPresenter < BasePresenter
  presents :unit

  def display_name
    UnitPresenter.unit_display_name(unit)
  end

  def self.unit_display_name(unit)
    "#{I18n.t("units.#{unit.type.downcase}")} #{unit.number}"
  end
end
