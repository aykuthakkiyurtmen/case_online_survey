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
  context "when it is rspec test" do
    it "test guard rubocop and byebug" do
      described_class.create!(name: "musteri anketi")
      expect(described_class.first.name).to eq("musteri anketi")
    end
  end
end
