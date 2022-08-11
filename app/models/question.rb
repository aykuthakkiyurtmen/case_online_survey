# == Schema Information
#
# Table name: questions
#
#  id            :uuid             not null, primary key
#  question_type :integer
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  survey_id     :uuid             not null
#
# Indexes
#
#  index_questions_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#
class Question < ApplicationRecord
  has_many :options , dependent: :destroy
  belongs_to :survey

  validates :title, length: { maximum: 200 }, presence: true

  enum question_type: %i[text choice], _default: :text
end
