#-*- encoding: utf-8 -*-
module ApplicationHelper

  def link_to_remove_fields(name, f)
   f.hidden_field(:_destroy) + link_to_function( name, "remove_fields(this)", class: "btn")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')", class: "btn info")
  end

  def extract_help_content(help)
    help_content = []
    help.users.each do |user|
      fund_name = user.fund ? " Фонд: #{user.fund.name}" : ""
      user_info = "#{user.name} #{fund_name}"
      help_content.push content_tag(:div, user_info)
    end
    help_content.push "<br />"
    help_content.push content_tag(:p, help.description)
    help_content.push content_tag(:div, help.made_at)
    help_content.join
  end

  def group_options_for_select(gr, family, params = nil)
    if gr.group_options.length > 0
      res = gr.group_options.order(:updated_at).inject("") do |res, go|
        if family and family.group_options.include?(go)
          res << "<option selected=\"selected\" value=\"#{go.id}\">#{go.name}"
        elsif params and params[:group_options_id_in] and params[:group_options_id_in].include?(go.id.to_s)
          res << "<option selected=\"selected\" value=\"#{go.id}\">#{go.name}"
        else
          res << "<option value=\"#{go.id}\">#{go.name}"
        end
        res << "</option>"
      end
      raw(res)
    else
      ''
    end
  end

  def render_table(layout, row_count, family, edit = true)
    res = ""
    for i in (1..row_count.to_i)
      layouts = layout.where("name = '#{i.to_s}'").order(:name, :value)
      res << "<tr>" if layouts.length > 0
      layouts.each do |cell|
        res << "<td colspan=#{cell.start} rowspan=#{cell.end}>" if cell.groups.count > 0
        cell.groups.for_show.order(:position).each do |group|
          if edit
            res << render_select(group, family)
          else
            res << render_cell(group, family)
          end
        end
        res << "</td>" if cell.groups.for_show.count > 0
      end
      res << "</tr>" if layouts.length > 0
    end
    res
  end

  def render_select(group, family)
    "<div class=\"field\">
        <label>#{group.name}</label>
        <select name=\"group_option_ids[]\" id=\"group_options_ids[]\">
          #{group_options_for_select(group, family)}
        </select>
    </div>"
  end

  def render_cell(group, family)
    if family.groups.include?(group)
      "<div class=\"info\">
        <div class=\"info-name\">
          <span>#{group.name}</span>
        </div>
        <div class=\"info-value\">
          #{family.group_options.where(group_id: group.id).first.name}
        </div>
      </div>
      "
    else
      ""
    end
  end

  def city_edit(form)
    if form.object.class == MetaSearch::Searches::Family
      res = render_city_select(City.roots.first.children.first.children.first, form, true, true, true)
      res << content_tag(:div, "", class: "nested_select")
    elsif form.object.city
      parents = form.object.get_parents

      res = parents.inject("") do |res, city|
        res << render_city_select(city, form, false, true, false)
        res << '<div class="nested_select">'
      end
      parents.length.times {res << "</div>"}

      return raw(res)
    else
      res = render_city_select(City.roots.first.children.first.children.first, form, false, true, true)
      res << content_tag(:div, "", class: "nested_select")
    end
  end

  def get_parents(city)
    parents = [city]
    while (city = city.parent) and (city.name != "Респ. Дагестан")
      parents << city
    end
    parents.reverse!
  end

  def render_city_select(city, form, search = false, blank = false, no_select = false)
    options = city.siblings.order(:name).inject("") do |res, el|
      selected = ((city == el) and !no_select) ? 'selected="selected"' : ''
      res << "<option #{selected} value=\"#{el.id}\">#{el.name}</option>"
    end
    field_name = search ? :city_id_in : :city_id
    form.select field_name, options, include_blank: blank
  end

  def help_types_for_select(params)
    selected_id = params[:help_type].to_i
    puts "#{selected_id}|-------------------------"
    res = HelpType.all.inject("") do |res, type|
      selected = type.id == selected_id ? 'selected="selected"' : nil
      res << "<option #{selected} value=\"#{type.id}\">#{type.name}</option>"
    end
    raw(res)
  end

  def funds_for_select(params)
    selected_id = params[:fund_id].to_i
    res = Fund.all.inject("") do |res, fund|
      selected = fund.id == selected_id ? 'selected="selected"' : nil
      res << "<option #{selected} value=\"#{fund.id}\">#{fund.name}</option>"
    end
    raw(res)
  end

end
