module ApplicationHelper
   
  # sort columns
  def sortable(column, title = nil)  
    title ||= column
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"  
    link_to title, params.merge(:sort => column, :direction => direction), { :rel => 'tooltip', :data => { :delay => '800' }, :title => "click to sort this column ascending :: click again to sort this column descending", :class => css_class}
  end  

  #show the 5 most used tags: "tag_id" => post_count
  def top_tags(most_used_tags)
    Hash[*most_used_tags.sort_by { |k,v| -v }[0..5].flatten]
  end

  #needed in home, because i need the tag_id for the link, but a user wants more. e.g. name 
  def get_tagname(tag_id)
    Tag.find(tag_id) 
  end

  #remove nested field. used for new tag on post
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", { :rel => 'tooltip', :data => { :delay => '800' }, :title => "remove row. tag will not be attached to entry.", :class =>  "icon-trash" } )
  end

  #add nested field. used for new tag on post
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", { :rel => 'tooltip', :data => { :delay => '800' }, :title => "add new row to enter a new tag. tag will be attached to the entry.", :class => "icon-plus" } )
  end


  #google url shortener. place your API key in: config/google_api_key
  #  Google::UrlShortener::Base.api_key =  File.open('config/google_api_key').read
  Google::UrlShortener::Base.api_key = "false"
  def shorten_url(post_id)
    title = Post.find(post_id).title
    url = Google::UrlShortener::Url.new(:long_url => title)
    url.shorten! 
  end

end
