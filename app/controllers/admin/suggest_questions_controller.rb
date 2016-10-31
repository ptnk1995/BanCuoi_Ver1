class Admin::SuggestQuestionsController < AdminController
  before_action :logged_in_user
  before_action :verify_admin_access?
  before_action :load_suggest, only: [:destroy, :edit]
  before_action :load_categories, only: :edit

  def index
    @suggests = SuggestQuestion.recent.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def create
  end

  def edit
    @question = Question.new(content: @suggest.content,
      pattern: @suggest.pattern, category_id: @suggest.category_id)
    @suggest.update_attributes(status: true)
    @question.save
      @suggest.suggest_answers.each do |f|
        @answer = Answer.new(question_id: @question.id, content: f.content,
          is_correct: f.is_correct)
        @answer.save
      end
      redirect_to admin_suggest_questions_path
  end

  def destroy
    if @suggest.destroy
      flash[:success] = t "suggest_user.destroy_success"
      redirect_to admin_suggest_questions_path
    else
      flash[:danger] = t "suggest_user.destroy_danger"
      redirect_to admin_root_path
    end
  end

  private

    def load_suggest
      @suggest = SuggestQuestion.find_by id: params[:id]
      if @suggest.nil?
        flash[:success] = t "suggest_user.not_found"
        redirect_to root_path
      end
    end

    def load_categories
      @category = Category.all
    end
end
