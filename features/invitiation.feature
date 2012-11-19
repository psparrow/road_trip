Feature: Itinerary Invitations

  Scenario: Users can allow other users to collaborate on their itineraries
    Given that I am a logged-in user
    And I have an itinerary
    When I give an existing user access to the itinerary
    Then they are alerted about the itinerary
    When they follow the login link
    Then the itinerary is listed in their itineraries

  Scenario: Users can invite non-users to collaborate on their itineraries
    Given that I am a logged-in user
    And I have an itinerary
    When I give a non-user access to the itinerary
    Then they are sent an invitation to join the site
    When they join via the join link
    Then the itinerary is listed in their itineraries
