require 'spec_helper'

describe ExpensesController do
  describe 'POST create' do
    context 'with allowed parameters' do
      let(:expense_params) do
        {
          price: 9,
          date: Time.now,
          description: 'description',
          tag_list: 'food'
        }
      end

      it 'saves an expense' do
        expect { post :create, expense_params, format: :json }.to change { Expense.count }.by(1)
      end
    end

    context 'with forbidden parameters' do
      let(:expense_params) { { } }

      it 'saves an expense' do
        expect { post :create, expense_params, format: :json }.to_not change { Expense.count }
      end
    end
  end
end