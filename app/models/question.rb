class Question < ApplicationRecord
  has_many :options
  enum type: [:text, :choice], _default: :text
end
