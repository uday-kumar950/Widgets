class WidgetsController < ApplicationController
  require 'will_paginate/array'

  def index
  	if params[:user_id].present?
  		@user_details = WidgetService.new.get_user_details(current_user,params[:user_id])
  		@widgets = WidgetService.new.user_widgets(current_user,params[:user_id]) 
  	else
  		@widgets = WidgetService.new.visible_data
    end
  	@widgets = @widgets.paginate(page: params[:page], per_page: 5)
  end

  def search
  	if params[:user_id].present?
  		@user_details = WidgetService.new.get_user_details(current_user,params[:user_id])
  		@widgets = WidgetService.new.user_widgets(current_user,params[:user_id]) 
  	else
  		@widgets = WidgetService.new.search_visible_widget(params[:term])
  	end
  	@widgets = @widgets.paginate(page: params[:page], per_page: 5)
  end

  def new
  	@widget = Widget.new  	
  end

end
