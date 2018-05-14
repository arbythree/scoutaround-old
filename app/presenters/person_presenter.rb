class PersonPresenter < BasePresenter
  presents :person

  def display_name
    "#{person.first_name} #{person.last_name}"
  end
end
