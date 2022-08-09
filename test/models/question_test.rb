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
require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
