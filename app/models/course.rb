class Course < ApplicationRecord
  validates :title, :description, :end_date, presence: true

  def active?
    Date.today <= end_date
  end
end
