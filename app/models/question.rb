class Question < ApplicationRecord
  enum type: [:text, :choice], _default: :text
end
