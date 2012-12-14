module ApplicationHelper
   
  # sort columns
  def sortable(column, title = nil)  
    title ||= column
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"  
    link_to title, params.merge(:sort => column, :direction => direction), {:class => css_class}
  end  

  #show the 5 most used tags: "tag_id" => post_count
  def top_tags(most_used_tags)
    Hash[*most_used_tags.sort_by { |k,v| -v }[0..5].flatten]
  end

  #needed in home, because i need the tag_id for the link, but a user wants more. e.g. name 
  def get_tagname(tag_id)
    Tag.find(tag_id) 
  end

  #remove field. used for new tag on post
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :class => "icon-trash")
  end

  #add field. used for new tag on post
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => "icon-plus")
  end



end
