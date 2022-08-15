# == Schema Information
#
# Table name: options
#
#  id          :uuid             not null, primary key
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :uuid             not null
#
# Indexes
#
#  index_options_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#
FactoryBot.define do
  factory :option do
    association :question, factory: :question
    title { "haftada bir" }
  end
end
