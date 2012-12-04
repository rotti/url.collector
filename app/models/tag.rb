class Tag < ActiveRecord::Base
  #belongs_to :post
  #has_and_belongs_to_many :post
  has_and_belongs_to_many :posts
  attr_accessible :name

  validates :name, :uniqueness => true, :presence => true,
                    :length => { :minimum => 3 }


 # module UrlHelper
 #   def url_with_protocol(url)
 #     /^http/.match(url) ? url : "http://#{url}"
 #   end
 # end

end
