Feature: Itinerary Management

  Scenario: Users can create itineraries
    Given that I am a logged-in user
    When I create an itinerary
    Then it is listed in my itineraries

  Scenario: Users can view their itineraries
    Given that I am a logged-in user
    And I have an itinerary
    When I view my itinerary listing
    Then I can access each itinerary
