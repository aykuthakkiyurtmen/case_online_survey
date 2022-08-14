FactoryBot.define do
  factory :question do
    association :survey, factory: :survey
    title { "test" }
    question_type { "choice" }
  end
end