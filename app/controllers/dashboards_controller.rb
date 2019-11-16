class DashboardsController < ApplicationController

  def index
  end

  def services
    @services = Service.all
  end

  def gallery
    @galleries = Gallery.all
  end
end

