class Activity < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :action_type, presence: true
  validates :target_id, presence: true
  validates :target_type, presence: true

  scope :recent, ->{order created_at: :desc}

  class << self
    def create_activity user_id, action_type, target_type, target_id
      Activity.create user_id: user_id, action_type: action_type,
      target_type: target_type, target_id: target_id
    end
  end

  def name_target target_type
    case target_type
    when 0
      user = User.find_by id: target_id
      user ? user.name : ""
    when 1
      user = User.find_by id: target_id
      user ? user.name : ""
    end
  end

  def name_action action_type
    case action_type
    when 0
      "Follow"
    when 1
      "Unfollow"
    end
  end
end
