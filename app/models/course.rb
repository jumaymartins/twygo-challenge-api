class Course < ApplicationRecord
  has_many :lectures, dependent: :destroy

  validates :title, :description, :end_date, presence: true

  def active?
    Date.today <= end_date
  end
end
