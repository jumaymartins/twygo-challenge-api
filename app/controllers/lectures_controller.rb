class LecturesController < ApplicationController
  before_action :set_lecture, only: %i[ show update destroy ]

  def index
    @lectures = Lecture.all

    render json: @lectures
  end

  def show
    render json: @lecture
  end

  def create
    @lecture = Lecture.new(lecture_params)

    if @lecture.save
      render json: @lecture,
        include: [ :video ],
        video: { url: rails_blob_path(@lecture.video, disposition: "attachment") },
        status: :created,
        location: @lecture
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
    @lecture = Lecture.find(params[:id])
  end

  def lecture_params
    params.require(:lecture).permit(:title, :references, :video)
  end
end
