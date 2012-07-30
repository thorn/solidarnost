#-*- encoding: utf-8 -*-
class News < ActiveRecord::Base

  include ActionView::Helpers
  attr_accessible :news_type, :status, :text, :title

  scope :active, -> {where(status: 0)}
  scope :archived, -> {where(status: 1)}
  scope :families, -> {where(news_type: 0)}
  scope :visits, -> {where(news_type: 1)}
  scope :helps, -> {where(news_type: 2)}
  scope :info, -> {where(news_type: 3)}
  def read?
    status == 1
  end

  def read!
    update_attribute(:status, 1)
  end

  def unread!
    update_attribute(:status, 0)
  end

  def self.create_about(object)
    if object.class == Family
      attributes = {title: "Создана семья #{object.title}", text: "Ссылка: <a href='/families/#{object.id}'>#{object.title}</a>", news_type: 0 }
    elsif object.class == Visit
      attributes = {title: "Совершен визит в семью #{object.family.title} c приоритетом #{object.family.priority}", text: "Ссылка: <a href='/families/#{object.family.id}'>#{object.created_at}</a><br /> Описание:<br><pre>#{object.description}</pre>", news_type: 1 }
    elsif object.class == FamilyHelp
      attributes = {title: "Оказана помощь семье #{object.family.title} c приоритетом #{object.family.priority}", text: "Ссылка: <a href='/families/#{object.family.id}'>#{object.created_at}</a><br /> Описание:<br><pre>#{object.description}</pre>", news_type: 2 }
    end

    News.create!(attributes)
  end
end
