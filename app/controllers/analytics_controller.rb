class AnalyticsController < ApplicationController
  before_action :set_should_render_navbar
  def show
    @daily_profile_views = current_user.get_daily_profile_views
  end

  private

  def set_should_render_navbar
    @should_render_navbar = true
  end
end
