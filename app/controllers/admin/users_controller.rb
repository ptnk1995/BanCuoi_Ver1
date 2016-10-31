class Admin::UsersController < AdminController
  before_action :load_users, except: [:create, :new , :index]
  protect_from_forgery with: :exception

  def index
    @users = User.recent.paginate page: params[:page],
      per_page: Settings.per_page_users
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "user_admin.flash.create_success"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "user_admin.flash.update_success"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_admin.flash.destroy_success"
    else
      flash[:danger] = t "user_admin.flash.destroy_danger"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :role
  end

  def load_users
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "user_admin.flash.find_danger"
      redirect_to admin_users_path
    end
  end
end
