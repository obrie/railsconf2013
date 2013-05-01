evt = /process_action.action_controller/

ActiveSupport::Notifications.subscribe(evt) do |*, payload|
  controller = payload[:controller]
  action = payload[:action]
  format = payload[:format]
  path = "#{controller}.#{action}.#{format}"

  status = payload[:status]
  Testapp.statsd.increment("#{path}.#{status}")
end