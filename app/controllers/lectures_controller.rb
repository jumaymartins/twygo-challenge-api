class LecturesController < ApplicationController
  before_action :set_course, only: %i[ create ]
  before_action :set_lecture, only: %i[ show update destroy ]

  def index
    @lectures = Lecture.where(course_id: params[:course_id])

    paginate json: @lectures
  end

  def show
    render json: @lecture
  end

  def create
    @lecture = Lecture.new(lecture_params)
    @lecture.course = @course

    if @lecture.save
      render json: @lecture, status: :created
    else
      render json: @lecture.errors, status: :unprocessable_entity
    end
  end

  def update
    if @lecture.update(lecture_params)
      render json: @lecture
    else
      render json: @lecture.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @lecture.destroy!
  end

  private

  def set_lecture
    @lecture = Lecture.find_by(id: params[:id], course_id: params[:course_id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def lecture_params
    params.require(:lecture).permit(:course_id, :title, :references, :video)
  end
end
