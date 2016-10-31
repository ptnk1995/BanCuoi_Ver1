class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.recent.paginate page: params[:page], per_page:
      Settings.per_page_users
  end

  def new
    @user = User.new
  end

  def show
    @activities = @user.activities.recent
  end

  def edit
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "new_user.success"
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "new_user.update"
      redirect_to root_url
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "new_user.danger"
      redirect_to root_url
    end
  end

  def correct_user
    redirect_to root_url unless current_user.is_user? @user
  end
end
