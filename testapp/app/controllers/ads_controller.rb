class AdsController < ApplicationController
  def show
    Testapp.statsd.increment('views')
  end
end