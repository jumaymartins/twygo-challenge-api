FactoryBot.define do
  factory :lecture do
    title { "Aula 1 - basico de logica de programacao" }
    references { "https://fictional-site.com" }
    video { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/video.mp4'), 'video/mp4') }
    course { association :course }
  end
end
