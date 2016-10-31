class SuggestQuestionsController < ApplicationController
  before_action :logged_in_user
  before_action :load_suggest, except: [:new, :create, :index]
  before_action :load_category, only: [:new, :create, :edit]

  def index
    @suggests = SuggestQuestion.recent.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @suggest = SuggestQuestion.new
    @suggest.suggest_answers.build
  end

  def create
    @suggest = SuggestQuestion.new suggest_params
    if @suggest.save
      flash[:success] = t "suggest_user.create_success"
      redirect_to suggest_questions_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @suggest.update_attributes suggest_params
      flash[:success] = t "suggest_user.update_success"
      redirect_to suggest_questions_path
    else
      render :edit
    end
  end

  def destroy
    if @suggest.destroy
      respond_to do |format|
        format.html {redirect_to suggest_questions_url}
        format.js
      end
    else
      flash[:danger] = t "suggest_user.destroy_danger"
      redirect_to suggest_questions_path
    end
  end

  private
    def suggest_params
      params.require(:suggest_question).permit(:content, :pattern,
        :category_id,
        suggest_answers_attributes: [:id, :content, :is_correct,
        :suggest_question_id, :_destroy]).merge! user: current_user
    end

    def load_suggest
      @suggest = SuggestQuestion.find_by id: params[:id]
      if @suggest.nil?
        flash[:success] = t "suggest_user.not_found"
        redirect_to root_path
      end
    end

    def load_category
      @category = Category.all
    end

end
