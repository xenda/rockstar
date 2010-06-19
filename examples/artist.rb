require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'scrobbler'))

# Please enter your API-Keys into lastfm.yml first. 
# You can find them here : http://www.lastfm.de/api/account
Scrobbler.lastfm = YAML.load_file(File.join(File.dirname(__FILE__), 'lastfm.yml'))

artist = Scrobbler::Artist.new('Madonna')

puts 'Top Tracks'
puts "=" * 10
artist.top_tracks.each { |t| puts "(#{t.reach}) #{t.name}" }

puts

puts 'Similar Artists'
puts "=" * 15
artist.similar.each { |a| puts "(#{a.match}%) #{a.name}" }