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
require "rails_helper"

RSpec.describe Option, type: :model do
  it { should validate_length_of(:title).is_at_most(40)}
  it { is_expected.to validate_presence_of(:title) }
end
