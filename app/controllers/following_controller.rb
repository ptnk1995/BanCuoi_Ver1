class FollowingController < ApplicationController

  def index
    @title = t "user_infor.following"
    @user = User.find_by id: params[:user_id]
    unless @user
      flash[:danger] = t "new_user.danger"
      redirect_to root_url
    end
    @users = @user.following.recent.paginate page: params[:page], per_page:
      Settings.per_page_users
    render "users/show_follow"
  end
end
