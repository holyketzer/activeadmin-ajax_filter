FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "Item #{n+1}" }
    subcategory
  end
end