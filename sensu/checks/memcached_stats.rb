#!/usr/bin/env ruby
require 'sensu-plugin/metric/cli'
require 'memcached'

class MemcachedStats < Sensu::Plugin::Metric::CLI::Graphite
  def run
    cache = Memcached.new('localhost:11211')
    cache.stats.each do |k, v|
      output "memcached.#{k}", v
    end
    ok
  end
end