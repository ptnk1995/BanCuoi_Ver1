class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    check_user @user
    current_user.follow @user
    create_user_follow_activity current_user, @user
    respond_to do |format|
      format.html  {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    check_user @user
    current_user.unfollow @user
    create_user_unfollow_activity current_user, @user
    respond_to do |format|
      format.html  {redirect_to @user}
      format.js
    end
  end

  def check_user user
    unless user
      flash[:danger] = t "new_user.danger"
      redirect_to root_url
    end
  end

  def show
    @activities = current_user.activities
  end
end
