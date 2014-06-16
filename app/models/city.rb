#-*- encoding: utf-8 -*-
require "nokogiri"
require "csv"
module Parser
  class CityParser
    def initialize(filename)
      City.delete_all
      @document = Nokogiri::XML(File.open(filename))
      root = create_root
      recursive_parse(root.id, root.aoguid)
      true
    end

    def recursive_parse(parent_id, find_node_id)
      @document.css("Object[PARENTGUID=\"#{find_node_id}\"]").each do |el|
        unless City.find_by_aoguid(el[:AOGUID])
          new_parent = create_city(el, parent_id)
          recursive_parse(new_parent.id, el[:AOGUID])
        else
          create_city(el, nil)
        end
      end
    end

    def create_root
      root = City.create(name: "Россия", aoguid: "0")
      dag = @document.at_css('Object[AOGUID="0bb7fa19-736d-49cf-ad0e-9774c4dae09b"]')
      # dag = @document.at_css('Object[AOGUID="b2d8cd20-cabc-4deb-afad-f3c4b4d55821"]')
      daghestan = create_city dag, root.id
    end

    def create_city(el, parent_id = nil)
      name = el[:SHORTNAME].length <= 3 ? "#{el[:SHORTNAME]}. #{el[:OFFNAME]}" : "#{el[:SHORTNAME]} #{el[:OFFNAME]}"
      attr = {
        name:       name,
        aoguid:     el[:AOGUID],
        parent_id:  parent_id
      }
      City.create(attr)
    end
  end
end

class City < ActiveRecord::Base
  attr_accessible :parent_id, :ancestry, :name, :aoguid, :prefix
  has_ancestry
  has_many  :families, :dependent => :destroy
  include Parser

  def self.parse_all
    s = CityParser.new(File.join(File.expand_path(File.dirname(__FILE__)), 'daghestan.xml'))
    # s = CityParser.new(File.join(File.expand_path(File.dirname(__FILE__)), 'ingushetia.xml'))
  end

  def name
    insert = (prefix && prefix.length > 3) ? "#{prefix}." : prefix
    "#{insert} #{super}"
  end

  # def parent_id=(parent_id)
  #   return false unless parent_id
  #   parent = City.find_by_id(parent_id)
  #   new_ancestry = parent.ancestry.nil? ? parent.aoguid : parent.ancestry + "/#{parent.aoguid}"
  #   update_attribute :ancestry, new_ancestry
  # end

  # def children
  #   child_ancestry = ancestry.nil? ? aoguid : ancestry + "/#{aoguid}"
  #   City.where("ancestry LIKE '#{child_ancestry}'")
  # end

  def self.order_cities
    Hirb.enable
    root = City.roots.first.children.first # Дагестан
    cities = root.children.where("name LIKE 'г. %'")
    cities.each do |city|
      city_copy = City.create(name: city.name, aoguid: city.aoguid, parent_id: city.id)
      city.children.each do |child|
        child.update_attribute(:parent_id, city_copy.id) if child.children.length.zero?
      end
    end
    false
  end
end
