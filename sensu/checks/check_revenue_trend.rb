#!/usr/bin/env ruby
require 'sensu-handler'
require 'batsd'
class CheckRevenueTrend < Sensu::Plugin::Metric::CLI::JSON
  option :warn, :short => '-w VALUE'
  option :crit, :short => '-c VALUE'

  def run
    t1 = Time.now
    t2 = t1 - 3600
    revenues = (1..4).map do |week|
      revenue(t2 - week * 604800, t1 - week * 604800)
    end

    line = LineFit.new
    line.setData(1..4, revenues)
    expected = line.forecast(5)
    actual = revenue(t2, t1)

    output(:expected => expected, :actual => actual)
    critical if (expected - actual).abs > line.meanSqError
    ok
  end

  def revenue(t2, t1 = Time.now)
    b = Batsd.new(:host => '127.0.0.1')
    b.values('counters:revenue', t2, t1).reduce(:+)
  end
end
