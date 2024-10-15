class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show destroy ]

  def index
    @reports = Report.all.order(created_at: :desc)

    paginate json: @reports
  end

  def show
    render json: @report
  end

  def create
    begin
      excel_filepath = excel_generator.course_videos_total_size(filters)
    rescue NotEnoughDataError => e
      render json: e.message, status: :unprocessable_entity
      return
    end

    @report = Report.new
    @report.excel_file.attach(
      File.open(Rails.root.join(excel_filepath))
    )

    if @report.save
      excel_generator.delete_excel(excel_filepath)
      render json: @report, status: :created
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy!
  end

  private

  def excel_generator
    ExcelGenerator.new
  end

  def set_report
    @report = Report.find(params[:id])
  end

  def filters
    params.permit(:course_created_before, :course_created_after)
  end
end
