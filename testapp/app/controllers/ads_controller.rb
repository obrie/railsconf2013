class AdsController < ApplicationController
  def show
    Testapp.statsd.increment('ad_views')
  end
end