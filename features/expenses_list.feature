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
    And I should see Edit links for each expense

  Scenario: Ability to edit expense
    Given I have 1 expense
    When I go to the index page
    And I click Edit
    Then the expense form should not be empty