Given(/^I am logged in$/) do

end

Given(/^I go to the index page$/) do
  visit root_path
end

When(/^I fill in$/) do |table|
    table.hashes.each do |option|
    option.each do |key, value|
      input = page.first("input[name=#{key.downcase}]") || page.first("textarea[name=#{key.downcase}]")
      input.set(value)
    end
  end
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