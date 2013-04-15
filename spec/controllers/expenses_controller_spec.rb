require 'spec_helper'

describe ExpensesController do
  describe 'POST create' do
    context 'with allowed parameters' do
      let(:expense_params) { { price: 1.00, date: Time.now, description: 'expense' } }

      it 'saves an expense' do
        expect { post :create, expense: expense_params, format: :json }.to change { Expense.count }.by(1)
      end
    end

    context 'with forbidden parameters' do
      let(:expense_params) { { } }

      it 'saves an expense' do
        expect { post :create, expense: expense_params, format: :json }.to_not change { Expense.count }
      end
    end
  end
end