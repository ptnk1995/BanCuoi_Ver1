class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      store_location
      flash[:warning] = t "new_user.warning"
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to root_url unless current_user.is_user? @user
  end

  def verify_admin
    unless logged_in? && current_user.admin?
      redirect_to root_path
    end
  end

  def create_user_follow_activity current_user, user
    action_type = Settings.activity.action_type.follow
    current_user.activities.create target_type:
      Settings.activity.target_type.create_relationship,
      target_id: user.id, action_type: action_type
  end

  def create_user_unfollow_activity current_user, user
    action_type = Settings.activity.action_type.unfollow
    current_user.activities.create target_type:
      Settings.activity.target_type.destroy_relationship,
      target_id: user.id, action_type: action_type
  end
end
