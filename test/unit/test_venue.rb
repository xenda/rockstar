require File.expand_path('../../test_helper.rb', __FILE__)

class TestVenue < Test::Unit::TestCase
  
  test "should get venues by name and country" do
    venues = Rockstar::Venue.find({:venue => 'cotton', :country => 'DE'})
    assert_equal(3, venues.size)
    assert_equal("Cotton Club", venues.first.name)
    assert_equal("Hamburg", venues.first.city)
    assert_equal("Germany", venues.first.country) 
  end

end