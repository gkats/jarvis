FactoryGirl.define do
  factory :expense do
    price "9.99"
    date Time.now

    factory :expense_with_tags do
      tag_list 'food'
    end
  end
end