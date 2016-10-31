class Category < ApplicationRecord
  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :suggest_questions, dependent: :destroy

  validates :name, presence: true, length: {minimum: 5}

  scope :recent, ->{order name: :asc}

  def random_question
    self.questions.random
  end
end
