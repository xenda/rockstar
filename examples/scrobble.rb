require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'scrobbler'))

# Please enter your API-Keys into lastfm.yml first. 
# You can find them here : http://www.lastfm.de/api/account
Scrobbler.lastfm = YAML.load_file(File.join(File.dirname(__FILE__), 'lastfm.yml'))

# This is the desktop app aproach to token auth. See Scrobbler::TokenAuth for
# details on how to get a token for a web app.

a = Scrobbler::Auth.new
token = a.token

puts
puts "Please open http://www.last.fm/api/auth/?api_key=#{Scrobbler.lastfm_api_key}&token=#{token}"
puts
puts "Press enter when done."

gets

session = a.session(token)

auth = Scrobbler::TokenAuth.new({:username => session.username, :token => session.key})
auth.handshake!

puts "Auth Status: #{auth.status}"
puts "Session ID: #{auth.session_id}"
puts "Now Playing URL: #{auth.now_playing_url}"
puts "Submission URL: #{auth.submission_url}"

scrobble = Scrobbler::Scrobble.new(:session_id => auth.session_id,
                                   :submission_url => auth.submission_url,
                                   :artist => 'Coldplay',
                                   :track => 'Viva La Vida',
                                   :album => 'Viva La Vida',
                                   :time => Time.new,
                                   :length => 244,
                                   :track_number => 7)
scrobble.submit!
puts "Scrobbler Submission Status: #{scrobble.status}"

# Love the Song :
l_status = Scrobbler::Track.new('Coldplay', 'Viva La Vida').love(session.key)

puts "Love track status : #{l_status}"

playing = Scrobbler::Playing.new(:session_id => auth.session_id,
                                 :now_playing_url => auth.now_playing_url,
                                 :artist => 'Anberlin',
                                 :track => 'A Day Late',
                                 :album => 'Never Take Friendship Personal',
                                 :length => 214,
                                 :track_number => 5)
                                 
playing.submit!         
puts "Playing Submission Status: #{playing.status}"      