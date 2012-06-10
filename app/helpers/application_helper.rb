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

end
