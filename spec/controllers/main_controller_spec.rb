require 'spec_helper'

describe MainController do
  describe '#index' do
    it 'assigns expenses' do
      create :expense, tags: [create(:tag)]
      get :index
      assigns(:expenses).should have(1).item
    end
  end
end