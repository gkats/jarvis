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
  end

  it 'has a script to bootstrap the client-side app' do
    render
    rendered.should have_css 'script[type="text/javascript"]'
  end
end