# == Schema Information
#
# Table name: surveys
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_surveys_on_name  (name) UNIQUE
#
class Survey < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :name, length: { maximum: 40 }, presence: true
end
