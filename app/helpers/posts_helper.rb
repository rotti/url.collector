module PostsHelper
  def join_tags(post)
    post.tags.map { |t| t.name }.join(", ")
  end

  #use nice strings in _show for create/update dates
  def create_date(post)
    " created at: " + post.created_at.strftime("%d %b. %Y") + " - " + post.created_at.strftime("%H:%M") 
  end
  def update_date(post)
    " updated at: " + post.updated_at.strftime("%d %b. %Y") + " - " + post.updated_at.strftime("%H:%M") 
  end

  #set a string and title(new) for submit button in _form
  if @current_action == "edit" or "update"
    @action_string = "update entry "
  elsif @current_action == "new" or "create"
    @action_string = "create entry"
    @action_title = "new entry" 
  end

end
