Feature: Itinerary Stops

  Scenario: Users can add stops to itineraries
    Given that I am a logged-in user
    And that I have an itinerary
    When I add a stop to the itinerary
    Then it is listed in the stops
