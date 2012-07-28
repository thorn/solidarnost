class Admin::NewsController < Admin::BaseController

  def index
    @news = News.scoped
  end

  def mark_as_read
  end

end
