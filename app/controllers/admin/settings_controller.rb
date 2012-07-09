#-*- encoding: utf-8 -*-
class Admin::SettingsController < Admin::BaseController

  before_filter :find_setting, only: [:show, :edit, :destroy, :update]

  def index
    @settings = Setting.scoped
  end

  def show
  end

  def new
    @setting = Setting.new
  end

  def edit
  end

  def update
    if @setting.update_attributes(params[:setting])
      redirect_to admin_settings_path
    else
      render :new
    end
  end

  def create
    @setting = Setting.new(params[:setting])
    if @setting.save
      redirect_to admin_settings_path
    else
      render :new
    end
  end

  def destroy
    @setting.destroy
  end

  def find_setting
    @setting = Setting.find(params[:id])
  end
end
