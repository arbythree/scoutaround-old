class Api::ApiController < ApplicationController
  http_basic_authenticate_with :name => ENV['API_USERNAME'], :password => ENV['API_PASSWORD']
  skip_before_action :verify_authenticity_token
  before_action :protect

  def protect
    whitelist = ENV['API_WHITELIST']

    return unless whitelist.present?

    ips = whitelist.gsub(' ', '').split(',')
    current_ip = request.remote_ip

    ap ips
    ap current_ip

    valid = ips.include?(current_ip)
    unless valid
      render json: { errors: ["#{ current_ip } is not permitted"] }, status: 401
    end
  end
end
