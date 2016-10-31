class QuestionExam < ApplicationRecord
  belongs_to :question
  belongs_to :exam

  has_many :answer_chooses, dependent: :destroy
  has_many :answers, through: :answer_chooses

  accepts_nested_attributes_for :answer_chooses, allow_destroy: true


  validates :exam, presence: true
  validates :question, presence: true


  def build_answer_chooses
    if question.multi?
      question.answers.each do |answer|
        unless self.answers.include? answer
          self.answer_chooses.build answer_id: answer.id
        end
      end
    else
      self.answer_chooses.build if self.answer_chooses.empty?
    end
  end

  def check_correct
    if answer_chooses.count == 0
      is_correct = false
    else
      if question.single?
        is_correct = answer_chooses.first.answer.is_correct
      else
        number_correct = question.answers
          .where(is_correct: true).count
        is_correct = answer_chooses.joins(:answer)
          .where(answers: {is_correct: true}).count == number_correct
      end
    end
    self.update is_correct: is_correct
  end
end
