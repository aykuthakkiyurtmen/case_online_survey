FactoryBot.define do
  factory :feedback do
    association :survey, factory: :survey
  end
end