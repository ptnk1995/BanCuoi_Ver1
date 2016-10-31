class Admin::QuestionsController < AdminController
  before_action :logged_in_user
  before_action :verify_admin_access?
  before_action :load_question, except: [:new, :create, :index]
  before_action :load_categories, only: [:new, :create, :edit]

  def index
    @questions = Question.recent.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @suggest = SuggestQuestion.find_by id: params[:id]
    @question = Question.new
    @question.answers.build
  end

  def create
    binding.pry
    @question = Question.new question_params
    if @question.validate_answers?
      if @question.save
        flash[:success] = t "question_admin.create_success"
        redirect_to admin_questions_path
      else
        render :new
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.validate_answers?
      if @question.update_attributes question_params
        flash[:success] = t "question_admin.update_success"
        redirect_to admin_questions_path
      else
        render :edit
      end
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      respond_to do |format|
        format.html {redirect_to questions_url}
        format.js
      end
    end
  end

  private
    def question_params
      params.require(:question).permit :content, :pattern, :category_id,
        answers_attributes: [:id, :content, :is_correct, :_destroy]
    end

    def load_question
      @question = Question.find_by id: params[:id]
      if @question.nil?
        flash[:success] = t "question_admin.not_found"
        redirect_to admin_root_path
      end
    end

    def load_categories
      @category = Category.all
    end
end
