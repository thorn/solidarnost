class StatisticsController < ApplicationController
  def index
    @priorities = Setting.priority
  end

  def show

  end
private

  def gather_info
  end
end
