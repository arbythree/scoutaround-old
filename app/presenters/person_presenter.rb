class PersonPresenter < BasePresenter
  presents :person

  def display_name
    "#{person.first_name} #{person.last_name}"
  end

  def type
    t("people.#{person.type.downcase}")
  end

  def rank
    person.rank
  end
end
