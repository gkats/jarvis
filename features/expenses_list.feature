@javascript
Feature: List expenses
  In order to keep track of my expenses
  As a user
  I want to view my expenses and manage them

  Background:
    Given I am logged in

  Scenario: Empty expenses list
    Given I have 0 expenses
    When I go to the index page
    Then I should see a expenses-empty message

  Scenario: Expenses List
    Given I have 2 expenses
    When I go to the index page
    Then I should not see a expenses-empty message
    And there should be 2 expenses

  Scenario: Ability to edit expense
    Given I have 1 expense
    And the expense form is empty
    When I go to the index page
    And I select the first expense
    Then the expense form should not be empty

  Scenario: Expenses tags
    Given I have 1 expense with tags "food, drinks"
    When I go to the index page
    Then there should be 1 expense
    And I should see "food, drinks"