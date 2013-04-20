FactoryGirl.define do
  factory :tag do
    sequence :name do |n| "tag_#{n}" end
  end
end