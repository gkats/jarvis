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
  end

  describe '#tag_list' do
    subject { expense.tag_list }
    let(:expense) { build :expense }
    before(:each) { expense.stub(:tags).and_return tags }

    context 'when expense has two tags "food" and "drinks"' do
      let(:tags) { [double({ name: 'food' }), double({ name: 'drinks' })] }

      it { should eq 'food, drinks' }
    end

    context 'when expense has no tags' do
      let(:tags) { [] }

      it { should be_blank }
    end
  end

  describe '#tag_list=' do
    subject { expense.tag_list = names }
    let(:expense) { build(:expense) }

    context 'with a list of two tags' do
      let(:names) { 'food, drinks' }

      it 'creates two tags' do
        expect { subject }.to change { Tag.count }.by(2)
        expense.tags.should have(2).items
      end

      context 'when the tags exist' do
        before(:each) do
          create :tag, name: 'food'
          create :tag, name: 'drinks'
        end

        it 'creates no tags' do
          expect { subject }.to_not change { Tag.count }
          expense.tags.should have(2).items
        end
      end
    end
  end

  describe '#as_json' do
    subject { expense.as_json }
    let(:expense) { build :expense, tag_list: 'food' }

    it 'returns only specific attributes' do
      %w[id price date description tag_list].each do |attr|
        subject[attr].should eq expense.public_send(attr)
        subject.delete attr
      end
      subject.should be_empty
    end
  end
end