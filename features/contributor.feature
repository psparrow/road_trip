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

  Scenario Outline: Only Administrators can invite contributors
    Given that I am a logged-in user
    And I have the <role_type> role on an itinerary
    Then I <can_invite> invite contributors to the itinerary
    Examples:
      | role_type     | can_invite |
      | Administrator | can        |
      | Contributor   | cannot     |
      | Read Only     | cannot     |

  Scenario Outline: Admins and Contributors can reorder stops
    Given that I am a logged-in user
    And I have the <role_type> role on an itinerary
    And the itinerary has multiple stops
    When I view the itinerary
    Then I <can_reorder_stops> move stops up
    And I <can_reorder_stops> move stops down
    And I <can_reorder_stops> move stops to the top
    And I <can_reorder_stops> move stops to the bottom
    Examples:
      | role_type     | can_reorder_stops |
      | Administrator | can               |
      | Contributor   | can               |
      | Read Only     | cannot            |

