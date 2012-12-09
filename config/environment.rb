# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Blog::Application.initialize!

#override the standard way of rails tagging a wrong field with bootstrap css
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  '<div class="alert alert-error"">'.html_safe << html_tag << '</div>'.html_safe
end


