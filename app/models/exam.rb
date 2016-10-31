class Exam < ApplicationRecord
  has_many :question_exams, dependent: :destroy
  has_many :questions, through: :question_exams

  belongs_to :user
  belongs_to :category

  validates :category, presence: true
  validates :user, presence: true

  enum status: {start: 0, testing: 1, uncheck: 2, checked: 3}

  accepts_nested_attributes_for :question_exams
  before_create :create_exam_questions
  after_create :set_default

  scope :recent, ->{order created_at: :desc}

  def score
    question_exams.where(is_correct: true).count
  end

  def calculate_mark
    question_exams.each do |question_exam|
      question_exam.check_correct
    end
  end

  def get_remain_time
     endtime = self.started_at + 50
     seconds = endtime.to_i - Time.now.to_i
  end

  private
  def create_exam_questions
    self.questions = self.category.random_question
  end

  def set_default
    self.start!
    self.update mark: Settings.exams.default_mark
  end
end
