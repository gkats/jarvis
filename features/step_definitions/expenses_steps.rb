Given(/^I have (\d+) expenses?$/) do |num|
  create_list :expense, num.to_i
end

Then(/^there should be (\d+) expenses?$/) do |number|
  selector = '.expenses tbody tr'
  if number.to_i.zero?
    page.first(selector).should be_nil
  else
    begin
      page.find selector
    rescue Capybara::Ambiguous
    end
    page.all(selector).should have(number.to_i).items
  end
end

Then(/^I should see the list of expenses$/) do
  page.should have_selector '#expenses'
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
