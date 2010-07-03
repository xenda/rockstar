require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'scrobbler'))

# Please enter your API-Keys into lastfm.yml first. 
# You can find them here : http://www.lastfm.de/api/account
Scrobbler.lastfm = YAML.load_file(File.join(File.dirname(__FILE__), 'lastfm.yml'))

album = Scrobbler::Album.new('Carrie Underwood', 'Some Hearts', :include_info => true)

puts "Album: #{album.name}"
puts "Artist: #{album.artist}"
puts "URL: #{album.url}"
puts "Release Date: #{album.release_date.strftime('%m/%d/%Y')}"
puts "Large cover: #{album.image_large}"
puts
puts
puts "Summary: #{album.summary}"
