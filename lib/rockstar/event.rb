module Rockstar
  class Event < Base
    
    attr_accessor :eid, :title, :artists, :headliners, :start_date, :end_date,
                  :description, :attendance, :reviews, :tag, :url, :website, :tickets, 
                  :cancelled
    
    class << self
      def new_from_xml(xml, doc)
        e = Event.new(
          (xml).at(:id).inner_html, 
          (xml).at(:title).inner_html
        )

        e.artists = []
        xml.search("/artists/artist").each {|a|
          e.artists << a.inner_html
        }

        e.headliners = []
        xml.search("/artists/headliner").each{|h|
          e.headliners <<  h.inner_html
        }

        e.start_date  = Time.parse(xml.search("/startDate").inner_html.strip)
        e.end_date    = Time.parse(xml.search("/endDate").inner_html.strip)
        e.description = xml.search("/description").inner_html.strip
        e.attendance  = xml.search("/attendance").inner_html.strip.to_i
        e.reviews     = xml.search("/reviews").inner_html.strip.to_i
        e.tag         = xml.search("/tag").inner_html.strip
        e.url         = xml.search("/url").inner_html.strip
        e.website     = xml.search("/website").inner_html.strip
        e.cancelled   = xml.search("/cancelled").inner_html.strip == 1

        e.tickets = []
        xml.search("/tickets/ticket").each{|t|
          e.tickets << t.inner_html
        }

        e
      end
    end
    
    def initialize(id, title)
      raise ArgumentError, "ID is required" if id.blank?
      raise ArgumentError, "Title is required" if title.blank?
      @eid   = id
      @title = title
    end
    
  end
end

