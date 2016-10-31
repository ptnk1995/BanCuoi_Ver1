class Question < ApplicationRecord
  has_many :answers, dependent: :destroy, inverse_of: :question
  has_many :question_exams
  belongs_to :category

  validates :category, presence: true
  accepts_nested_attributes_for :answers, allow_destroy: true
  enum pattern: {multi: 0, single: 1}

  scope :recent, ->{order created_at: :desc}
  scope :random, ->{order("RANDOM()").limit Settings.exams.number_question}

  def validate_answers?
   self.answers.select{|answer| answer.is_correct?}.count >= Settings.single
  end
end
