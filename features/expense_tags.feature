@javascript
Feature: Expense tags
  In order to organize my expenses
  As a user
  I want to provide tags for my expenses

  Scenario: Show tags in expenses list
    Given I have 2 tagged expenses
    When I go to the index page
    Then I should see 2 listed tags