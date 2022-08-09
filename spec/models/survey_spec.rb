require "rails_helper"

RSpec.describe Survey, type: :model do
  context "when it is rspec test" do
    it "test guard rubocop and byebug" do
      described_class.create!(name: "musteri anketi")
      expect(described_class.first.name).to eq("musteri anketi")
    end
  end
end
