require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  it 'creates new course when is valid params' do
    post :create, params: params

    new_courses = Course.all

    expect(response).to have_http_status(:created)
    expect(new_courses.length).to eq(1)
    expect(new_courses.first.title).to eq(params[:course][:title])
  end

  it 'do not create new course when do not have valid params' do
    post :create, params: params(title: '')

    expect(response).to have_http_status(:unprocessable_content)
  end

  it 'updates course with passed id' do
    course = create(:course)

    put :update, params: params(title: 'new title').merge({ id: course.id })

    updated_course = Course.find(course.id)

    expect(response).to have_http_status(:success)
    expect(updated_course.title).to eq('new title')
  end

  it 'return all active courses' do
    first_active_course = create(:course, end_date: Date.today)
    second_active_course = create(:course, end_date: Date.today + 5.days)
    inative_course = create(:course, end_date: Date.today - 1.days)

    get :index

    parsed_response = JSON.parse(response.body)

    expect(response).to have_http_status(:success)
    expect(parsed_response.length).to eq(2)
    expect(parsed_response.map { |course| course["id"] }).not_to include(inative_course.id)
  end

  it 'return founded course with passed id' do
    course = create(:course)

    get :show, params: { id: course.id }

    parsed_response = JSON.parse(response.body)

    expect(response).to have_http_status(:success)
    expect(parsed_response["title"]).to eq(course.title)
  end

  it 'delete course with passed id' do
    course = create(:course)

    delete :destroy, params: { id: course.id }

    found_courses = Course.all

    expect(response).to have_http_status(:success)
    expect(found_courses.length).to eq(0)
  end

  private

  def params(title: 'title')
    {
      course: {
        title: title,
        description: 'description',
        end_date: Date.today
      }
    }
  end
end
