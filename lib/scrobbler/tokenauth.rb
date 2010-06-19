require 'digest/md5'

# exception definitions
class BadAuthError < StandardError; end
class BannedError < StandardError; end
class BadTimeError < StandardError; end
module Scrobbler
  
  # Token Authentification
  #
  # There are 2 ways to get an auth token : 
  # 
  # = Desktop-App =
  # 1. Get a new token to request authorisation:
  #     token = Scrobbler::Auth.new.token
  # 2. Open a webbrowser with http://www.last.fm/api/auth/?api_key=xxxxxxxxxxx&token=xxxxxxxx
  # 3. Wait for the User to confirm that he accepted your request. Continue with step 4 below
  #
  # = Web-App = 
  # 1. Step: redirect the user to http://www.last.fm/api/auth/?api_key={YOUR_API_KEY}&amp;cb={YOUR_RETURN_URL}
  # 2. Step: if the user excepts, lastfm will redirect to YOUR_RETURN_URL?token=TOKEN
  # 3. Continue with step 4 below
  #
  # 4. Get the token and call 
  #     new Scrobbler::Auth.new.session(token) 
  #    with that token. 
  # 5. Store the session.key and session.username returned. The session.key will not
  #    expire. It is save to store it into your database.
  # 6. Use this token to authentificate with this class :
  #     auth = Scrobbler::TokenAuth.new({:username => 'chunky', :token => 'bacon'})
  #     auth.handshake!
  # 
  class TokenAuth
    # you should read last.fm/api/submissions#handshake

    attr_accessor :user, :token, :client_id, :client_ver
    attr_reader :status, :session_id, :now_playing_url, :submission_url

    def initialize(args = {})
      @user = args[:username] # last.fm user
      @token = args[:token] # last.fm token
      @client_id = 'rbs' # Client ID assigned by last.fm; Don't change this!
      @client_ver = Scrobbler::Version

      raise ArgumentError, 'Missing required argument' if @user.blank? || @token.blank?
      
      @connection = REST::Connection.new(Scrobbler::AUTH_URL)
    end

    def handshake!
      timestamp = Time.now.to_i.to_s
      auth = Digest::MD5.hexdigest("#{Scrobbler.lastfm_api_secret}#{timestamp}")

      query = { :hs => 'true',
                :p => AUTH_VER,
                :c => @client_id,
                :v => @client_ver,
                :u => @user,
                :t => timestamp,
                :a => auth,
                :api_key=>Scrobbler.lastfm_api_key,
                :sk => @token }
      result = @connection.get('/', true, query)

      @status = result.split(/\n/)[0]
      case @status
      when /OK/
        @session_id, @now_playing_url, @submission_url = result.split(/\n/)[1,3]
      when /BANNED/
        raise BannedError # something is wrong with the gem, check for an update
      when /BADAUTH/
        raise BadAuthError # invalid user/password
      when /FAILED/
        raise RequestFailedError, @status
      when /BADTIME/
        raise BadTimeError # system time is way off
      else
        raise RequestFailedError
      end  
    end
  end
end