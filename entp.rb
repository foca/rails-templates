# entp.rb
# from Jeremy McAnally
 
plugin 'context', :git => 'git://github.com/jeremymcanally/context.git'
plugin 'matchy', :git => 'git://github.com/jeremymcanally/matchy.git'
plugin 'rr', :git => 'git://github.com/btakita/rr.git'
plugin 'machinist', :git => 'git://github.com/notahat/machinist.git'
plugin 'storyteller', :git => 'git://github.com/foca/storyteller.git'
plugin 'webrat', :git => 'git://github.com/brynary/webrat.git'
 
plugin 'app_bootstrap', :git => 'git://github.com/technoweenie/app_bootstrap.git'
plugin 'restful-authentication', :git => 'git://github.com/technoweenie/restful-authentication.git'
plugin 'active_record_context', :git => 'git://github.com/technoweenie/active_record_context.git'
plugin 'attachment_fu', :git => 'git://github.com/technoweenie/attachment_fu.git'
plugin 'thinking-sphinx', :git => 'git://github.com/freelancing-god/thinking-sphinx.git'
 
gem 'mislav-will_paginate', :source => 'http://gems.github.com/', :lib => 'will_paginate'
gem 'rubyist-aasm', :source => 'http://gems.github.com/', :lib => 'aasm'
 
initializer "concerns.rb" do
  puts 'class << ActiveRecord::Base'
  puts '  def concerned_with(*concerns)'
  puts '    concerns.each do |concern|'
  puts '      require_dependency "#{name.underscore}/#{concern}"'
  puts '    end'
  puts '  end'
  puts 'end'
end

file "config/routes.rb", <<-CODE
ActionController::Routing::Routes.draw do |map|
end
CODE

generate 'authenticated', 'user session --aasm'
 
run 'rm public/index.html'
run 'rm log/*'
run 'mv config/database.yml config/database.sample.yml'
 
file '.gitignore', <<-CODE
config/database.yml
config/*.sphinx.conf
db/*.sqlite*
db/sphinx/*
log/*
tmp/*
.DS_Store
CODE
 
git :init
git :add => "."
git :commit => "-a -m 'Initial commit'"
