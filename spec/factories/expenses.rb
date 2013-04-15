FactoryGirl.define do
  factory :expense do
    price "9.99"
    date Time.now
  end
end