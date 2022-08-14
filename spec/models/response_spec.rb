# == Schema Information
#
# Table name: responses
#
#  id          :uuid             not null, primary key
#  body        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  feedback_id :uuid             not null
#  option_id   :uuid
#  question_id :uuid             not null
#
# Indexes
#
#  index_responses_on_feedback_id  (feedback_id)
#  index_responses_on_option_id    (option_id)
#  index_responses_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (feedback_id => feedbacks.id)
#  fk_rails_...  (option_id => options.id)
#  fk_rails_...  (question_id => questions.id)
#
require "rails_helper"

RSpec.describe Response, type: :model do
  let(:response) { create(:response) }

  describe "validations" do
    it { is_expected.to validate_length_of(:body).is_at_most(200) }
  end

  describe "relations" do
    it { is_expected.to belong_to(:question) }
    it { is_expected.to belong_to(:option).optional }
  end
end
