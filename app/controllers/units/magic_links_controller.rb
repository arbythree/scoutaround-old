class Units::MagicLinksController < Units::UnitContextController
  def index
    @magic_links = @unit.magic_links
  end
end
