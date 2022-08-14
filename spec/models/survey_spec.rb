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
  let(:survey) { create(:survey) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(40) }
  end

  describe "relations" do
    it { is_expected.to have_many(:questions) }
    it { is_expected.to have_many(:feedbacks) }
  end
end
