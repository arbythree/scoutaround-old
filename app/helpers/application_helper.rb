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

  def stripe_connect_path
    [
      'https://connect.stripe.com/express/oauth/authorize?client_id=',
      ENV['STRIPE_CONNECT_CLIENT_ID']
    ].join
  end

  def select_time(name, html_options = {}, tag_options = {})
    values = ''
    values += '<option value="0">All day</option>' if tag_options[:display_all_day_option]
    (7..23).step(1).each do |hour|
      meridian = hour >= 12 ? 'PM' : 'AM'
      display_hour = (hour > 12) ? hour - 12 : hour
      values += "<option value=\"#{ format('%02d', hour) }:00\">#{ display_hour }:00 #{ meridian }</option>"
      values += "<option value=\"#{ format('%02d', hour) }:30\">#{ display_hour }:30 #{ meridian }</option>"
    end
    select_tag(name, raw(values), html_options)
  end
end
