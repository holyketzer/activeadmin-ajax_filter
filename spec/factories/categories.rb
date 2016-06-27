FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n+1}" }
  end
end