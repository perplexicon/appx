FeedEntry.all.each do |entry|
  filename = "test/#{entry.id}.html"
  target = open(filename, 'w')
  content = entry.content
  target.write(content)
end
