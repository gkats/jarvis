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

  describe 'PUT update' do
    let(:expense) { create :expense }
    let(:price) { expense.price }

    context 'with valid parameters' do
      before(:each) do
        expense.price = price + 10
      end

      it 'updates the expense' do
        put :update, expense.attributes, format: :json
        expense.price.should eq (price + 10)
      end
    end

    context 'with invalid parameters' do
      before(:each) do
        expense.price = nil
      end

      it 'does not update the expense' do
        put :update, expense.attributes, format: :json
        expense.price.should eq price
      end
    end
  end
end