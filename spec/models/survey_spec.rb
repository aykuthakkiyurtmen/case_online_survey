require 'rails_helper'

RSpec.describe Survey, type: :model do
  context 'it is rspec test' do
    it 'test guard rubocop and byebug' do
      Survey.create!(name: 'musteri anketi')
      expect(Survey.first.name).to eq('musteri anketi')
    end
  end
end
