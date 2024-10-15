FactoryBot.define do
  factory :report do
    excel_file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/excel.xlsx'), 'excel/xlsx') }
  end
end
