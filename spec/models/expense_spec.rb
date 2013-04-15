require 'spec_helper'

describe Expense do
  describe '#valid?' do
    subject { expense.valid? }

    context 'with blank price' do
      let(:expense) { build :expense, price: nil }

      it 'returns false' do
        subject.should be_false
        expense.should have(1).errors_on(:price)
      end
    end

    context 'with non-numeric price' do
      let(:expense) { build :expense, price: 'invalid' }

      it 'returns false' do
        subject.should be_false
        expense.should have(1).errors_on(:price)
      end
    end

    context 'with blank date' do
      let(:expense) { build :expense, date: nil }

      it 'returns false' do
        subject.should be_false
        expense.should have(1).errors_on(:date)
      end
    end

    context 'with no tags' do
      it 'returns false'
    end
  end
end