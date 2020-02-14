#! /usr/bin/env ruby

File.open("Gemfile", "a") do |f|
  f.puts "\n# next two lines was added by scripts. Prease remove this lines before commit."
  f.puts "gem 'pry-rails', group: [:development, :test]"
  f.puts "gem 'pry-byebug', group: [:development, :test]"
end

value = `bundle install`
if $?.success?
  puts 'success add gems'
else
  puts value
end
