#-*- encoding: utf-8 -*-
class Admin::NewsController < Admin::BaseController

  before_filter :gather_info, only: [:index, :new]
  def index
    case params[:filter]
      when "archived"
        @news = News.archived.order(:created_at).page(params[:page]).per_page(100)
        @header = "Архив новостей"
      when "families"
        @news = News.active.families.order(:created_at).page(params[:page]).per_page(100)
        @header = "Созданные семьи"
      when "visits"
        @news = News.active.visits.order(:created_at).page(params[:page]).per_page(100)
        @header = "Совершенные визиты"
      when "helps"
        @news = News.active.helps.order(:created_at).page(params[:page]).per_page(100)
        @header = "Оказанная помощь"
      when "info"
        @news = News.active.info.order(:created_at).page(params[:page]).per_page(100)
        @header = "Информационные оповещения"
      else
        @news = News.active.order(:created_at).page(params[:page]).per_page(100)
        @header = "Все новости"
      end
  end

  def mark_as_read
    @news = News.find(params[:id])
    if @news and @news.read?
      @news.unread!
    else
      @news.read!
    end
    redirect_to :back
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(params[:news].merge(status: 0, news_type: 3))
    @news.save!
    redirect_to admin_news_index_path
  end

  def destroy
    @news = News.find(params[:id]).destroy
    redirect_to admin_news_index_path
  end

  private
    def gather_info
      @info = {
        archived: News.archived.count,
        families: News.active.families.count,
        visits: News.active.visits.count,
        helps: News.active.helps.count,
        active: News.active.count,
        info: News.active.info.count
      }
    end

end
