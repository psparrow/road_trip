Feature: Itinerary Management

  Scenario: Users can create itineraries
    Given that I am a logged-in user
    When I create an itinerary
    Then it is listed in my itineraries
    When I select an itinerary
    Then I can view that itinerary

  Scenario: Users can edit itineraries
    Given that I am a logged-in user
    And I have an itinerary
    When I edit that itinerary
    Then the itinerary is updated
