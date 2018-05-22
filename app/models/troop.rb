class Troop < Unit
  def ranks
    %w(scout tenderfoot second_class first_class star life eagle).map { |key| I18n.t("ranks.#{key}") }
  end
end
