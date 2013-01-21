Feature: Invitations

  Scenario: Users can invite non-users to contribute to itineraries
    Given that I am a logged-in user
    And I have an itinerary
    When I invite a non-user to the itinerary
    Then they are invited to join the site
    When they accept the invitation
    Then they can view the itinerary
    And they can add stops to the itinerary

  Scenario: Users can invite existing users to contribute to itineraries
    Given that I am a logged-in user
    And I have an itinerary
    When I invite an existing user to the itinerary
    Then they are notified about the invitation
    When they login
    Then they can view the itinerary
    And they can add stops to the itinerary
