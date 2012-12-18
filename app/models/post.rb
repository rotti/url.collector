class Post < ActiveRecord::Base
  #in the view the columns are called different. see config/locales and the views
  #title = url
  #content = description
  attr_accessible :content, :name, :title, :tags_attributes, :tag_ids, :tag_id, :tag, :tag_tokens

  has_many :comments, :dependent => :destroy
  has_and_belongs_to_many :tags

  validates :name,  :presence => true, :length => { :minimum => 3 }
  validates :title, :presence => true,
                    :format => URI::regexp(%w(http https)),
                    :length => { :minimum => 5 }

  accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  attr_reader :tag_tokens  
    
  def tag_tokens=(ids)  
    self.tag_ids = ids.split(",")  
  end 


  #simple search interface for all columns of the post
  def self.search(search)  
    if search  
      where('name || title || content LIKE ?', "%#{search}%")  
    else  
      scoped  
    end  
  end 

  #show all posts on a specific tag
  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  #previous post by id
  def previous_post
    self.class.first(:conditions => ["id < ?", id], :order => "id desc")
  end

  #next post by id
  def next_post
    self.class.first(:conditions => ["id > ?", id], :order => "id asc")
  end

end
