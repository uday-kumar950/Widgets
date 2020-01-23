class WidgetsController < ApplicationController
  require 'will_paginate/array'

  def index
  	if params[:user_id].present?
  		@widgets = WidgetService.new.user_widgets(current_user,params[:user_id]) 
  	else
  		@widgets = WidgetService.new.visible_data
    end
  	@widgets = @widgets.paginate(page: params[:page], per_page: 5)
  end

  def search
  	if params[:user_id].present?
  		@widgets = WidgetService.new.search_user_visible_widgets(current_user,params[:user_id],params[:term]) 
  	else
  		@widgets = WidgetService.new.search_visible_widgets(params[:term])
  	end
  	@widgets = @widgets.paginate(page: params[:page], per_page: 5)
  end

  def new
  end

  def create
  	@is_widget_created = WidgetService.new.create_widget(current_user,params[:widget])
  	if @is_widget_created
  		flash[:notice] = "New widget created successfully"
  	end
  end

  def edit
  	@widget_id = params[:id]
  end

  def update
  	@is_widget_updated = WidgetService.new.update_widget(current_user,params[:widget],params[:id])
  	if @is_widget_updated
  		flash[:notice] = "Widget updated successfully"
  	end
  end

  def destroy
  	is_widget_deleted = WidgetService.new.delete_widget(current_user,params[:id])
  	if is_widget_deleted
  		flash[:notice] = "Widget deleted successfully"
  	else
  		flash[:alert] = "Widget not deleted!!"
  	end
  	redirect_to widgets_path
  end

end
