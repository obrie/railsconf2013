class Conversion < ActiveRecord::Base
  after_create do
    Testapp.statsd.increment('conversions')
    Testapp.statsd.increment('revenue', revenue)
  end
end