FactoryGirl.define do
  factory :subcategory do
    sequence(:name) { |n| "Subcategory #{n+1}" }
    category
  end
end