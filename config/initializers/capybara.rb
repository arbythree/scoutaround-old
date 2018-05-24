Capybara::Webkit.configure do |config|
  config.allow_url("pro.fontawesome.com")
  config.allow_url("cloud.typography.com")
end

Capybara.javascript_driver = :webkit

Capybara.register_server :thin do |app, port, host|
  require 'rack/handler/thin'
  Rack::Handler::Thin.run(app, Host: host, Port: port)
end
