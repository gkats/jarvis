Given(/^I have (\d+) expenses?$/) do |num|
  create_list :expense, num.to_i
end

Then(/^there should be (\d+) expenses?$/) do |number|
  page.all('#expenses tbody tr').should have(number).items
end

Then(/^I should see the list of expenses$/) do
  page.should have_selector '#expenses'
end

Then(/^I should see (.+) links for each expense$/) do |text|
  page.all('#expenses tbody tr a').each do |link|
    link.text.should =~ text
  end
end

Then(/^the expense form should not be empty$/) do
  inputs = page.all '#expense_form input'
  inputs.each do |input|
    input.value.should_not be_blank
  end
end

Then(/^I should see the expense form$/) do
  page.should have_selector '#expense_form'
end
