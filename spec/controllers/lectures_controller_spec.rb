require 'rails_helper'

RSpec.describe LecturesController, type: :controller do
  it 'creates new lecture when is valid params' do
    post :create, params: params

    new_lectures = Lecture.all

    expect(response).to have_http_status(:created)
    expect(new_lectures.length).to eq(1)
    expect(new_lectures.first.title).to eq(params[:lecture][:title])
  end

  it 'do not create new lecture when do not have valid params' do
    post :create, params: params(title: '')

    expect(response).to have_http_status(:unprocessable_content)
  end

  it 'updates lecture with passed id' do
    lecture = create(:lecture)

    put :update, params: params(title: 'new title').merge({ id: lecture.id })

    updated_lecture = Lecture.find(lecture.id)

    expect(response).to have_http_status(:success)
    expect(updated_lecture.title).to eq('new title')
  end

  it 'return all lectures' do
    first_lecture = create(:lecture)
    second_lecture = create(:lecture)

    get :index

    parsed_response = JSON.parse(response.body)

    expect(response).to have_http_status(:success)
    expect(parsed_response.length).to eq(2)
  end

  it 'return founded lecture with passed id' do
    lecture = create(:lecture)

    get :show, params: { id: lecture.id }

    parsed_response = JSON.parse(response.body)

    expect(response).to have_http_status(:success)
    expect(parsed_response["title"]).to eq(lecture.title)
  end

  it 'delete lecture with passed id' do
    lecture = create(:lecture)

    delete :destroy, params: { id: lecture.id }

    found_lectures = Lecture.all

    expect(response).to have_http_status(:success)
    expect(found_lectures.length).to eq(0)
  end

  private

  def params(title: 'title')
    {
      lecture: {
        title: title,
        references: 'references',
        video: fixture_file_upload('video.mp4')
      }
    }
  end
end
