class AnswerChoose < ApplicationRecord
  belongs_to :question_exam, optional: true
  belongs_to :answer

  validates :answer, presence: true
  validates :question_exam, presence: true
end
