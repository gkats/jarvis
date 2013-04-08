Given(/^I am logged in$/) do

end

Given(/^I go to the index page$/) do
  visit root_path
end

When(/^I fill in$/) do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

When(/^I click (.+)$/) do |clickable|
  click_link_or_button clickable
end

Then /^I should( not)? see an? (.+) message$/ do |negation, klass|
  msg = page.first ".#{klass}"
  unless negation
    msg.should be_visible
  else
    msg.should(be_nil) || msg.should_not(be_visible)
  end
end