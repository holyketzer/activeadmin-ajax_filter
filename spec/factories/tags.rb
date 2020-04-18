FactoryGirl.define do
  factory :tag do
    sequence(:name) { |n| "Tag #{n+1}" }
    subcategory
  end
end
