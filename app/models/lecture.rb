class Lecture < ApplicationRecord
  attr_accessor :title, :references

  has_one_attached :video, dependent: :destroy

  validates :title, :video, presence: true
  validate :validate_video

  private

  def validate_video
    if video.attached? && !video.content_type.in?(%w[video/mp4])
      errors.add(:video, "Must be a video MP4 format")
    end
  end
end
