require "test_helper"

class LectureTest < ActiveSupport::TestCase
  test 'validates presence of title' do
    lecture = create_lecture(title: nil)

    assert_not lecture.valid?
  end

  test 'validates presence of video attachment' do
    lecture = create_lecture(file_attached: false)

    assert_not lecture.valid?
  end

  test 'validates presence of video content type' do
    lecture = create_lecture(
      file_path: 'test/fixtures/files/image.jpg',
      filename: 'image.jpg'
    )

    assert_not lecture.valid?
  end

  private

  def create_lecture(
    title: 'valid_title',
    file_path: 'test/fixtures/files/video.mp4',
    filename: 'video.mp4',
    file_attached: true
  )
    lecture = Lecture.new(title: title)
    if file_attached
      lecture
        .video
        .attach(io: File.open(file_path), filename: filename)
    end
    lecture
  end
end
