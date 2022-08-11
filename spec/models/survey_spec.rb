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
require "rails_helper"

RSpec.describe Survey, type: :model do
  it { should validate_length_of(:name).is_at_most(40)}
  it { is_expected.to validate_presence_of(:name) }
end
