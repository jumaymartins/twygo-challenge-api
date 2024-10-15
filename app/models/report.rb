class Report < ApplicationRecord
  has_one_attached :excel_file, dependent: :destroy
end
