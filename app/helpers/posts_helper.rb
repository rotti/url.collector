module PostsHelper
  def join_tags(post)
    post.tags.map { |t| t.name }.join(", ")
  end

  def create_date(post)
    " created at: " + post.created_at.strftime("%d %b. %Y") + " - " + post.created_at.strftime("%H:%M") 
  end

  def update_date(post)
    " updated at: " + post.updated_at.strftime("%d %b. %Y") + " - " + post.updated_at.strftime("%H:%M") 
  end

end
