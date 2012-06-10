Feature: Creating family
  In order to create a family
  As a user
  I want to create them through web interface

  Scenario: creating family
    Given I am on the homepage
    When I follow "Внести новую семью"
    Then I should see "Идентификация семьи"
