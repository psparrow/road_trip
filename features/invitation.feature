Feature: Invitations

  Scenario Outline: Users can invite people to itineraries
    Given that I am a logged-in user
    And I have an itinerary
    When I invite a new user to the itinerary as a <role>
    Then they are invited to join the site
    And they have the <role> role on the itinerary
      | role          |
      | Administrator |
      | Contributor   |
      | Read Only     |

  Scenario Outline: Users can invite people to itineraries
    Given that I am a logged-in user
    And I have an itinerary
    When I invite an existing user to the itinerary as a <role>
    Then they are notified about the invitation
    And they have the <role> role on the itinerary
    Examples:
      | role          |
      | Administrator |
      | Contributor   |
      | Read Only     |
