#!/usr/bin/env ruby
require 'sensu-handler'
require 'batsd'
class CheckRevenueRate < Sensu::Plugin::Metric::CLI::JSON
  option :warn, :short => '-w VALUE'
  option :crit, :short => '-c VALUE'

  def run
    hour1 = Time.now - 3600
    hour2 = hour1 - 3600
    revenue1 = revenue(hour1)
    revenue2 = revenue(hour2, hour1)

    pct_diff = (revenue2 - revenue1 / revenue2.to_f)
    output(
      :hour1 => hour1, :revenue1 => revenue1,
      :hour2 => hour2, :revenue2 => revenue2
    )

    critical if pct_diff >= config[:crit]
    warning  if pct_diff >= config[:warn]
    ok
  end

  def revenue(t2, t1 = Time.now)
    b = Batsd.new(:host => '127.0.0.1')
    b.values('counters:revenue', t2, t1).map{|r| r[:values]}.reduce(:+)
  end
end