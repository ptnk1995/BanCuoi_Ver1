class ExamsController < ApplicationController
  before_action :logged_in_user
  before_action :load_exam, only: [:show, :update]

  def index
    @exam = current_user.exams.build
    @categories = Category.all
    @exams = current_user.exams.recent.page(params[:page])
      .per_page Settings.per_page
  end

  def create
    # binding.pry
    @exam = current_user.exams.build exam_params
    if @exam.save
      flash[:success] = t "created_exam"
      respond_to do |format|
        format.js
      end
    else
      redirect_to exams_path
      flash[:danger] = t "fail_created_exam"
    end

  end

  def show
    if @exam.start?
      if @exam.update_attribute(:status, "testing")
        @exam.update started_at: Time.now
        flash[:success] = t "user_admin.flash.update_success"
      end
    end
    @exam.question_exams.each do |question_exam|
      question_exam.build_answer_chooses
    end
  end

  def update
    if @exam.update_attributes exam_params
      @exam.get_remain_time
      @exam.calculate_mark
      flash[:success] = t "created_exam"
      redirect_to exams_path
    else
      flash[:danger] = t "fail_created_exam"
      redirect_to @exam
    end
  end

  private

  def exam_params
    params.require(:exam).permit :status,:category_id, question_exams_attributes:
      [:id, answer_chooses_attributes: [:id, :answer_id, :_destroy]]
  end

  def load_exam
    @exam = Exam.find_by id: params[:id]
    unless @exam
      flash[:danger] = t "exam_not_found"
      redirect_to root_path
    end
  end
end
