class Admin::CategoriesController < AdminController
  before_action :logged_in_user
  before_action :verify_admin_access?
  before_action :load_category, except: [:new, :create, :index]

  def index
    @categories = Category.recent.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def show
    @question = @category.questions.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category_admin.create_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "category_admin.update_success"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "category_admin.destroy_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "category_admin.destroy_danger"
      redirect_to admin_root_path
    end
  end

  private
    def category_params
      params.require(:category).permit :name
    end

    def load_category
      @category = Category.find_by id: params[:id]
      if @category.nil?
        flash[:success] = t "category_admin.not_found"
        redirect_to admin_root_path
      end
    end
end
