module Scrobbler
  
  class Auth < Base
    attr_accessor :token
    
    def initialize(token)
      raise ArgumentError, "Token is required" if token.blank?
      @token = token
    end
  
    # Returns the token for a session. You have to use
    # TokenAuth first and then use this class with the token
    # that is given by last.fm to create a session token
    # This session token can be stored in your database, it is
    # not expiring.
    # See Scrobbler::TokenAuth for a detailed example
    def session(force=false)
      sessions = get_instance("auth.getSession", :auth, :session, {:token => @token}, force, true)
      
      if (sessions.length > 0)
        sessions[0]
      else
        nil
      end
    end
  end
end