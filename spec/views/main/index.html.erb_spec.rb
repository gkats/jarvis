require 'spec_helper'

describe 'main/index' do
  describe 'section#main' do
    it 'exists' do
      render
      rendered.should have_css 'section#main'
    end

    it 'has an expenses data attribute' do
      render
      rendered.should have_css '#main[data-expenses]'
    end

    it 'has an expenses list' do
      render
      rendered.should have_css '#expenses_list'
    end

    it 'has an expense form' do
      render
      rendered.should have_css '#expense_form'
    end
  end

  it 'has a script to bootstrap the client-side app' do
    render
    rendered.should have_css 'script[type="text/javascript"]'
  end
end