require 'cgi'

module ApplicationHelper
  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def additional_classes
    @body_classes ||= []
    @body_classes.concat([controller.controller_name, controller.action_name]).join(' ')
  end

  def crumbtrail(element)
    @crumbtrail ||= []
    @crumbtrail << element
  end

  def submission_name(submission)
    "#{submission.user.full_name} #{submission.event_requirement.description}"
  end

  def google_maps_link(location)
    "https://www.google.com/maps/place/#{location.gsub(' ', '+')}"
  end

  def unit_name(unit)
    "#{I18n.t("units.#{unit.type.downcase}")} #{unit.number}"
  end

  def user_synopsis(users)
    result = users[0..2].map(&:full_name).join(', ')
    result += " and #{ users.count - 3 } others" if users.count > 3
    result
  end
end
