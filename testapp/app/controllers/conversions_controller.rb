class ConversionsController < ApplicationController
  def create
    Conversion.create(:revenue => rand(10))
    redirect_to ad_url(:id => params[:ad_id])
  end
end