Feature: Itinerary Management

  Scenario: Users can create itineraries
    Given that I am a logged-in user
    When I create an itinerary
    Then it is listed in my itineraries
    When I select an itinerary
    Then I can view that itinerary
