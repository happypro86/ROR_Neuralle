
FactoryGirl.define do
  factory :footer, :class => Refinery::Footers::Footer do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

