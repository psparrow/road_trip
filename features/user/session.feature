Feature: User sessions

  Scenario: User login
    Given that I have a user account
    When I submit the login form
    Then I am logged into the application
    When I logout
    Then I am no longer logged into the application
