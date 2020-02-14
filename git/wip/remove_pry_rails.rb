#! /usr/bin/env ruby

lines = []
removed = false

File.open("Gemfile", "r") do |f|
  lines = f.readlines
  f.reopen("Gemfile", "w")
  new_lines = []
  lines.each do |line|
    if line.chomp == "# next two lines was added by scripts. Prease remove this lines before commit."
      removed = true
      break
    end
    new_lines << line
  end

  new_lines.each do |line|
    f.print line
  end
end

if removed
  value = `bundle exec rubocop -ac .rubocop.yml Gemfile && bundle install`
  if $?.success?
    puts "Success remove pry-rails"
  else
    puts 'fail:'
    p value
  end
end
