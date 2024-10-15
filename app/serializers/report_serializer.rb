class ReportSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :created_at, :excel_file

  def excel_file
    rails_blob_path(object.excel_file, only_path: true, disposition: "attachment")
  end
end
