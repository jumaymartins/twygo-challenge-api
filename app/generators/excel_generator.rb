class ExcelGenerator
  include ActionView::Helpers::NumberHelper

  def initialize(overrides = {})
    @xlsx_package = overrides.fetch(:xlsx_package) do
      Axlsx::Package.new
    end
  end

  def course_videos_total_size(filters)
    courses = Course
      .where(
        "created_at >= ? AND created_at <= ?",
        filters[:course_created_after],
        filters[:course_created_before]
      )

    raise NotEnoughDataError.new(filters) if courses.empty?

    @xlsx_package.workbook.add_worksheet(name: "Report") do |sheet|
      sheet.add_row [
        "course_id",
        "course_title",
        "creation_at",
        "video_total_size"
      ]
      courses.each do |course|
        sheet.add_row [
          course.id,
          course.title,
          course.created_at,
          calculate_total_video_size(course.lectures)
        ]
      end
    end

    filepath = filepath(filters)

    @xlsx_package.serialize(filepath)

    filepath
  end

  def delete_excel(filepath)
    File.delete(filepath)
  end

  private

  def filepath(filters)
    "tmp/total_courses_size #{filters[:course_created_after]} - #{filters[:course_created_before]}.xlsx"
  end

  def calculate_total_video_size(lectures)
    total_byte_size = lectures.map do |lecture|
      lecture.video.byte_size
    end.sum

    number_to_human_size(total_byte_size)
  end
end
