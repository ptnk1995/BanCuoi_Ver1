class Admin::ExamsController < AdminController
  before_action :load_exam, only: [:show, :update, :destroy, :edit]

  def index
    @exams = Exam.recent.all.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @exam.uncheck?
      if @exam.update_attribute(:status, "checked")
        flash[:success] = t "user_admin.flash.update_success"
        page = params[:page]
        redirect_to admin_exams_path
      else
        redirect_to admin_exams_path
      end
    else
      if @exam.update_attribute(:status, "uncheck")
        flash[:success] = t "user_admin.flash.update_success"
        redirect_to admin_exams_path
      else
        redirect_to admin_exams_path
      end
    end
  end

  def destroy
    if @exam.destroy
      flash[:success] = t "user_admin.flash.destroy_success"
    else
      flash[:danger] = t "user_admin.flash.destroy_danger"
    end
    redirect_to admin_exams_path
  end

  private
  def load_exam
    @exam = Exam.find_by id: params[:id]
    unless @exam
      flash[:danger] = I18n.t "flash.danger.exam_not_found"
      redirect_to root_path
    end
  end
end
