class LectureSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :references, :video

  def video
    rails_blob_path(object.video, only_path: true, disposition: "attachment")
  end
end
