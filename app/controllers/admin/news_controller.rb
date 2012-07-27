class Admin::NewsController < Admin::BaseController

  def index
    @news = News.scoped
  end

  def mark_as_read
    read_ids = params[:ids]
    News.where(id: read_ids).each { |n| n.read = true }
  end

end
