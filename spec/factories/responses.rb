FactoryBot.define do
  factory :response do
    association :question, factory: :question
    association :option, factory: :option, optional: true
    body { "test response" }
  end
end