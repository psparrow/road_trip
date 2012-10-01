Feature: User Registration

  Scenario: User creates an account
    Given that I am registering for an account
    When I fill out the registration form
    Then I am registered as a user
