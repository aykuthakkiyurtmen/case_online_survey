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
class Option < ApplicationRecord
  belongs_to :question
  has_many :responses
  validates :title, length: { maximum: 40 }, presence: true
end
