Feature: Contributors with certain roles can perform certain actions on itineraries.

  Scenario Outline: All roles can view itineraries
    Given that I am a logged-in user
    And I have the <role_type> role on an itinerary
    Then I can view the itinerary
    Examples:
      | role_type     |
      | Administrator |
      | Contributor   |
      | Read Only     |

  Scenario Outline: Only Administrator and Contributor roles can add stops to itineraries
    Given that I am a logged-in user
    And I have the <role_type> role on an itinerary
    Then I <can_add_stops> add stops to the itinerary
    Examples:
      | role_type     | can_add_stops |
      | Administrator | can           |
      | Contributor   | can           |
      | Read Only     | cannot        |

  Scenario Outline: Only Administrators can edit itineraries
    Given that I am a logged-in user
    And I have the <role_type> role on an itinerary
    Then I <can_edit> edit the itinerary
    Examples:
      | role_type     | can_edit |
      | Administrator | can      |
      | Contributor   | cannot   |
      | Read Only     | cannot   |


