require 'rails_helper'

RSpec.describe Lecture, type: :model do
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

  private

  def create_lecture(
    title: 'valid_title',
    filename: 'video.mp4',
    file_format: 'video/mp4',
    file_attached: true
  )
    lecture = Lecture.new(title: title)
    if file_attached
      lecture
        .video
        .attach(fixture_file_upload(filename, file_format))
    end
    lecture
  end
end
