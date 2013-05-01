#!/usr/bin/env ruby
require 'sensu-handler'
require 'redphone/pagerduty'
class Pagerduty < Sensu::Handler
  def filter
    super
    bail 'create only' if @event['action'] != 'create'
  end

  def handle
    client, check = @event.values_at('client', 'check')
    id = client['name'] + '/' + check['name']
    Redphone::Pagerduty.trigger_incident(
      :service_key => settings['pagerduty']['api_key'],
      :incident_key => id,
      :description => id + ': ' + check['output']
    )
  end
end