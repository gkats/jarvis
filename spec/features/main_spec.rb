require 'spec_helper'

describe 'Main page' do
  it 'preloads any expenses' do
    expense = create :expense_with_tags
    visit root_path
    expenses = JSON.parse page.find('#main')['data-expenses']
    expenses.should have(1).item
  end

  it 'bootstraps the client side app', js: true do
    visit root_path
    jarvis = page.evaluate_script('window.Jarvis')
    expenses = jarvis['Collections']['Expenses']
    pending
  end
end