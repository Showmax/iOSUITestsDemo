Feature: Search screen

  Here I can add description of feature.
  And it can be multiline.
  Maybe even longer.

  Scenario: User search for unexisting content
    """
    Application should provide clear message about missing responses
    """
    Given I on Search screen
    When I search "Aaaa"
    Then I should see empty state note

  Scenario: Happy path
    """
    Application should work in happy path. So I able to search movies and see details for them
    """
    Given I on Search screen
    When I search "Ant-Man and"
    And I tap on first result
    Then Application should open detail of "Ant-Man and the Wasp" movie