Feature: Content
  In order to test some basic Behat functionality
  As a website user
  I need to be able to see that the Drupal and Drush drivers are working

# TODO: 'Given ... content' (below) works, but 'When I am viewing ... content'
# uses data that pantheonssh rejects

#  @api
#  Scenario: Create a node
#    Given I am logged in as a user with the "administrator" role
#    When I am viewing a "topic" content with the title "My topic"
#    Then I should see the heading "My topic"

  @api
  Scenario: Create many nodes
    Given "page" content:
    | title    |
    | Page one |
    | Page two |
    And "topic" content:
    | title        |
    | First topic  |
    | Second topic |
    And I am logged in as a user with the "administrator" role
    When I go to "admin/content"
    Then I should see "Page one"
    And I should see "Page two"
    And I should see "First topic"
    And I should see "Second topic"

# Setting the body field contents does not seem to be effective

#  @api
#  Scenario: Create nodes with fields
#    Given "topic" content:
#    | title                   | promote | body             |
#    | First topic with fields |       1 | PLACEHOLDER BODY |
#    When I am on the homepage
#    And follow "First topic with fields"
#    Then I should see the text "PLACEHOLDER BODY"

#  @api
#  Scenario: Create and view a node with fields
#    Given I am viewing an "Topic" content:
#    | title | My topic with fields! |
#    | body  | A placeholder           |
#    Then I should see the heading "My topic with fields!"
#    And I should see the text "A placeholder"

  @api
  Scenario: Create users
    Given users:
    | name     | mail            | status |
    | Joe User | joe@example.com | 1      |
    And I am logged in as a user with the "administrator" role
    When I visit "admin/people"
    Then I should see the link "Joe User"

  @api
  Scenario: Login as a user created during this scenario
    Given users:
    | name      | status | mail             |
    | Test user |      1 | test@example.com |
    When I am logged in as "Test user"
    Then I should see the link "Logout"

# Similarly, 'When I am viewing a ... term' also uses bad characters.

#  @api
#  Scenario: Create a term
#    Given I am logged in as a user with the "administrator" role
#    When I am viewing an "interests" term with the name "My interest"
#    Then I should see the heading "My interest"

  @api
  Scenario: Create many terms
    Given "interests" terms:
    | name         |
    | Interest one |
    | Interest two |
    And I am logged in as a user with the "administrator" role
    When I go to "admin/structure/taxonomy/manage/interests/overview"
    Then I should see "Interest one"
    And I should see "Interest two"

  @api
  Scenario: Create nodes with specific authorship
    Given users:
    | name     | mail            | status |
    | Joe User | joe@example.com | 1      |
    And "topic" content:
    | title        | author   | promote |
    | Topic by Joe | Joe User | 1       |
    When I am logged in as a user with the "administrator" role
    And I am on the homepage
    Then I should see the link "Topic by Joe"
    When I follow "Topic by Joe"
    Then I should see the text "Topic by Joe"
    # Todo: The node is created by 'Anonymous', but it should be created by 'Joe User'
    # And I should see the link "Joe User"
