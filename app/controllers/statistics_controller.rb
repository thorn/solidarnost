class StatisticsController < ApplicationController
  def index
    @priorities = Setting.priority
    @types = HelpType.scoped
    @types_for_month = HelpType.scoped
    @types_for_quater = HelpType.scoped
    @types_for_year = HelpType.scoped

  end

  def show

  end
private

  def gather_info
  end
end
