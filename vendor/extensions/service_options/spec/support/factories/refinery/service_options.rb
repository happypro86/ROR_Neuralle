
FactoryGirl.define do
  factory :service_option, :class => Refinery::ServiceOptions::ServiceOption do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

