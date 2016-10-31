class SuggestQuestion < ApplicationRecord
  has_many :suggest_answers, dependent: :destroy, inverse_of: :suggest_question

  belongs_to :user
  belongs_to :category

  validates :user, presence: true
  validates :category, presence: true
  validates :content, presence: true, length: {minimum: 5}
  validate :validate_suggest_answers, on: [:create]

  accepts_nested_attributes_for :suggest_answers, allow_destroy: true

  scope :recent, ->{order created_at: :desc}
  private
  def validate_suggest_answers
    if self.suggest_answers.select{|answer| answer.is_correct?}.count < Settings.single
      errors.add :suggest_answers, I18n.t("suggest_user.subject_quanlity_error")
    end
  end
end
