#-*- encoding: utf-8 -*-
module ApplicationHelper

  def link_to_remove_fields(name, f)
   f.hidden_field(:_destroy) + link_to_function( name, "remove_fields(this)", :class => "btn")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')", :class => "btn info")
  end

  def extract_help_content(help)
    help_content = []
    help.users.each do |user|
      help_content.push content_tag(:div, user.name)
    end
    help_content.push "<br />"
    help_content.push content_tag(:p, help.description)
    help_content.push content_tag(:div, help.made_at)
    help_content.join
  end

  def group_options_for_select(gr, family)
    res = gr.group_options.inject("") do |res, go|
      if family.group_options.include?(go)
        res << "<option selected=\"selected\" value=\"#{go.id}\">#{go.name}"
      else
        res << "<option value=\"#{go.id}\">#{go.name}"
      end
      res << "</option>"
    end
    res.html_safe
  end

  def render_table(layout, row_count, family)
    res = ""
    for i in (0..row_count) do
      layouts = layout.where("name = '#{i.to_s}'").order(:name, :value)
      res << "<tr>" if layouts.count > 0
      layouts.each do |cell|
        res << "<td colspan=#{cell.start} rowspan=#{cell.end}>" if cell.groups.count > 0
        cell.groups.order(:position).each do |group|
          res << "
          <div class=\"field\">
            <label>#{group.name}</label>
            <select name=\"group_options_ids[]\" id=\"group_options_ids[]\">
              #{group_options_for_select(group, family)}
            </select>
          </div>"
          #{cell.name}:#{cell.value}:#{cell.start}:#{cell.end}
        end
        res << "</td>" if cell.groups.count > 0
      end
      res << "</tr>" if layouts.count > 0
    end
    res
  end
end
