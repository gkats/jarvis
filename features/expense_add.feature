@javascript
Feature: Add expenses
  In order to store my expenses
  As a user
  I want to be able to add an expense

  Background:
    Given I am logged in
    And I have 0 expenses
    And I go to the index page
    Then I should see the expense form

  Scenario: Add new expense
    When I fill in
    | Price | Tag_list | Description           |
    | 9.99  | food     | Breakfast at Tiffanys |
    And I click Add
    Then there should be 1 expense
    And I should see an alert-success message

  Scenario: Fail to add expense
    When I fill in
    | Price | Tag_list | Description           |
    |       | food     | Breakfast at Tiffanys |
    And I click Add
    Then I should see the expense form
    And there should be 0 expenses
    And I should see an alert-error message