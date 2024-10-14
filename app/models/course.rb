class Course < ApplicationRecord
  has_many :lectures

  validates :title, :description, :end_date, presence: true

  def active?
    Date.today <= end_date
  end
end
