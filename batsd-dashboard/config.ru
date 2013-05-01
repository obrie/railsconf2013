require 'batsd-dash'

Batsd::Dash.config = {
  :host => 'localhost',
  :port => 8127,
  :size => 5,
  :timeout => 5,
  :view_path => File.expand_path('..', __FILE__)
}

require 'batsd-dash/app'
run Batsd::Dash::App