2# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def create_lectures(titles: [], course_id:)
  titles.each do |title|
    lecture = Lecture.new(
      title: title,
      course_id: course_id
    )
    lecture.video.attach(
      io: File.open(Rails.root.join('spec/fixtures/files/video.mp4')),
      filename: 'video.mp4'
    )
    lecture.save!
  end
end

rails_course = Course.find_or_create_by!(
  title: 'Learning Ruby and Rails',
  description: 'Course focaded in introduce basic features of framework Rails and to enable web development',
  end_date: Date.today + 15.days
)
create_lectures(
  titles: [
    'Aula 1 - What is a framework?',
    'Aula 2 - How internet works?',
    'Aula 3 - Basics of HTML and CSS'
  ],
  course_id: rails_course.id
)

react_course = Course.find_or_create_by!(
  title: 'Basics of React',
  description: 'Course focaded in introduce basic of React',
  end_date: Date.today - 15.days
)
create_lectures(
  titles: [
    'Aula 1 - Creating react project from zero',
    'Aula 2 - Aula 2 - Adding forms'
  ],
  course_id: react_course.id
)

database_course = Course.find_or_create_by!(
  title: 'Understanding the types of databases',
  description: 'Course will introduce some famous databases and its differences',
  end_date: Date.today + 30.days
)
create_lectures(
  titles: [ 'Aula 1 - Relational vs Non-Relational Databases' ],
  course_id: database_course.id
)
