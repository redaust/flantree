class AnalyticsController < ApplicationController
  before_action :set_should_render_navbar
  def show
  end

  private

  def set_should_render_navbar
    @should_render_navbar = true
  end
end
