Feature: Achievement page

  In order to read others achievements
  As a guest user
  I want to see public achievement

  Scenario: guest user sees publive achievement
    Given I am a guest user
    And there is a public achievement
    When I go to the achievement's page
    Then I must see achievement's content
