class Answer < ApplicationRecord
  belongs_to :question, optional: true, inverse_of: :answers
  has_many :answer_chooses, dependent: :destroy

  validates :question, presence: true
  validates :content, presence: true

  scope :recent, ->{oder created_at: :desc}
end
