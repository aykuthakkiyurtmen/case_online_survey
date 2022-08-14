FactoryBot.define do
  factory :option do
    association :question, factory: :question
    title { "haftada bir" }
  end
end