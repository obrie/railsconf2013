#!/usr/bin/env ruby
require 'sensu-plugin/check/cli'

class CheckLoad15 < Sensu::Plugin::Check::CLI
  option :warn, :short => '-w L15'
  option :crit, :short => '-c L15'

  def run
    avg = File.read('/proc/loadavg').split[2]
    critical(avg) if avg > config[:crit]
    warning(avg) if avg > config[:warn]
    ok
  end
end