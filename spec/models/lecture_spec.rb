require 'rails_helper'

RSpec.describe Lecture, type: :model do
  let(:default_course) { create(:course) }

  it 'validates presence of title' do
    lecture = create_lecture(title: nil)

    expect(lecture.valid?).to be false
  end

  it 'validates presence of video attachment' do
    lecture = create_lecture(file_attached: false)

    expect(lecture.valid?).to be false
  end

  it 'validates presence of video content type' do
    lecture = create_lecture(
      filename: 'image.jpg',
      file_format: 'image/jpg'
    )

    expect(lecture.valid?).to be false
  end

  it 'validates presence of course' do
    lecture = create_lecture(course: nil)

    expect(lecture.valid?).to be false
  end

  it 'permits creation of lecture when all params is valid' do
    lecture = create_lecture

    expect(lecture.valid?).to be true
  end

  private

  def create_lecture(
    title: 'valid_title',
    filename: 'video.mp4',
    file_format: 'video/mp4',
    file_attached: true,
    course: default_course
  )
    lecture = Lecture.new(title: title, course: course)
    if file_attached
      lecture
        .video
        .attach(fixture_file_upload(filename, file_format))
    end
    lecture
  end
end
