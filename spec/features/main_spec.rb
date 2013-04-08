require 'spec_helper'

describe 'Main page' do
  it 'preloads any expenses' do
    expense = create :expense
    visit root_path
    expenses = JSON.parse page.find('#main')['data-expenses']
    expenses.should have(1).item
  end
end