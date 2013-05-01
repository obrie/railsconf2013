#!/usr/bin/env ruby
require 'sensu-handler'
require 'statsd'
class StatsdPush < Sensu::Handler
  def filter; end

  def handle
    config = settings['statsd']
    statsd = Statsd.new(config['host'], config['port'])

    output = @event['check']['output']
    output.split("\n").each do |metric|
      key, value, * = metric.split
      statsd.timing(key, value)
    end
  end
end