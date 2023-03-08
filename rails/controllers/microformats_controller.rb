class MicroformatsController < ApplicationController
  def new
  end

  def create
    @data = Scraper.new(params[:source]).microformats
  end
end
