Feature: Invitations

  Scenario Outline: Users can invite people to itineraries
    Given that I am a logged-in user
    And I have an itinerary
    When I invite a new user to the itinerary as a <role>
    Then they are invited to join the site
    When they accept the invitation
    Then they <can_view> view the itinerary
    Then they <can_add_stops> add stops to the itinerary
    Examples:
      | role          | can_add_stops | can_view |
      | Read Only     | cannot        | can      |
      | Administrator | can           | can      |
      | Contributor   | can           | can      |

  Scenario Outline: Users can invite people to itineraries
    Given that I am a logged-in user
    And I have an itinerary
    When I invite an existing user to the itinerary as a <role>
    Then they are notified about the invitation
    When they login
    Then they <can_view> view the itinerary
    And they <can_add_stops> add stops to the itinerary
    Examples:
      | role          | can_add_stops | can_view |
      | Administrator | can           | can      |
      | Contributor   | can           | can      |
      | Read Only     | cannot        | can      |
