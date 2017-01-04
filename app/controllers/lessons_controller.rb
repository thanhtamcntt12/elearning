class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :init_lesson, only: [:show, :edit, :update]
  before_action :load_category, only: :create

  def show
    @results = @lesson.results
  end

  def create
    category = Category.find(params[:category_id])
    @lesson = category.lessons.create user: current_user
    if @lesson
      flash[:success] = t "created_lesson_success"
      redirect_to edit_category_lesson_path category, @lesson
    else
      flash[:danger] = t "created_lesson_fails"
      redirect_to categories_path
    end
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t "finished_lesson"
      redirect_to category_lesson_path
    else
      flash[:danger] = t "submit_error"
      render :edit
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id,
      results_attributes: [:id, :meaning_id]
  end

  def init_lesson
    @lesson = Lesson.find_by id: params[:id]
    unless @lesson
      flash[:danger] = t "created_lesson_fails"
      redirect_to categories_path
    end
  end

  def load_category
    category = Category.find_by id: params[:category_id]
    unless category
      flash[:danger] = t "user_load_fails_category"
      redirect_to new_admin_word_path
    end
  end
end
