#!/usr/bin/env ruby
require 'sensu-handler'
require 'batsd'
class CheckRevenue < Sensu::Plugin::Metric::CLI::JSON
  option :warn, :short => '-w VALUE'
  option :crit, :short => '-c VALUE'

  def run
    total = revenue(Time.now - 3600)
    critical if total < config[:crit]
    warning  if total < config[:warn]
    ok
  end

  def revenue(t2, t1 = Time.now)
    b = Batsd.new(:host => '127.0.0.1')
    b.values('counters:revenue', t2, t1).reduce(:+)
  end
end