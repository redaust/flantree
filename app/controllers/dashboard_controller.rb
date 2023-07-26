class DashboardController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:show]
  before_action :set_should_render_navbar, except: [:show]
  def index
    @should_render_navbar = true
  end

  def appearance
    @should_render_navbar = true
   end

   def donate
    @should_render_navbar = true
  end


  def show
    redirect_to dashboard_path if @user.nil?


    @links = @user.links.where.not(url: '', title: '')
    ahoy.track "Viewed Dashboard", user: @user

   end

  private

  def set_should_render_navbar
    @should_render_navbar = true
  end

  def set_user
    @user = User.find_by_id(params[:id])
  end
end