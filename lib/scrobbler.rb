%w{cgi rubygems hpricot active_support}.each { |x| require x }

$: << File.expand_path(File.dirname(__FILE__))

require 'scrobbler/base'
require 'scrobbler/version'

require 'scrobbler/album'
require 'scrobbler/artist'
require 'scrobbler/chart'
require 'scrobbler/user'
require 'scrobbler/tag'
require 'scrobbler/track'

require 'scrobbler/simpleauth'
require 'scrobbler/auth'
require 'scrobbler/session'
require 'scrobbler/tokenauth'
require 'scrobbler/scrobble'
require 'scrobbler/playing'

require 'scrobbler/rest'

module Scrobbler
  extend self
  
  def lastfm=(args)
    @api_key    = args["api_key"]
    @api_secret = args["api_secret"]
  end
  
  def lastfm_api_key
    @api_key
  end
  
  def lastfm_api_secret
    @api_secret
  end
end