class SuggestAnswer < ApplicationRecord
  belongs_to :suggest_question, optional: true, inverse_of: :suggest_answers

  validates :content, presence: true
  validates :suggest_question, presence: true

  scope :recent, ->{oder created_at: :desc}
end
