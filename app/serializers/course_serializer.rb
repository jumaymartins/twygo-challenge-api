class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :end_date

  def active
    object.active
  end
end
