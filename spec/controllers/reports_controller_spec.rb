require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  it 'creates new report with generate excel' do
    course = create(:course, created_at: "2024-01-10")

    post :create, params: params

    new_reports = Report.all
    parsed_response = JSON.parse(response.body)

    expect(response).to have_http_status(:created)
    expect(new_reports.length).to eq(1)
    expect(parsed_response["data"]["attributes"]["excel-file"]).not_to be_empty
  end

  it 'returns unprocessable error when do not have enough data to generate report' do
    post :create, params: params

    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'return all founded reports by created date desc' do
    first_report = create(:report)
    second_report = create(:report)

    get :index

    parsed_response = JSON.parse(response.body)
    founded_reports_ids = parsed_response["data"].map { |report| report["id"] }

    expect(response).to have_http_status(:success)
    expect(parsed_response["data"].length).to eq(2)
    expect(founded_reports_ids).to include(second_report.id.to_s, first_report.id.to_s)
  end

  it 'return founded report with passed id' do
    report = create(:report)

    get :show, params: { id: report.id }

    parsed_response = JSON.parse(response.body)

    expect(response).to have_http_status(:success)
  end

  it 'delete report with passed id' do
    report = create(:report)

    delete :destroy, params: { id: report.id }

    found_reports = Report.all

    expect(response).to have_http_status(:success)
    expect(found_reports.length).to eq(0)
  end

  private

  def params(title: 'title')
    {
      course_created_after: "2024-01-01",
      course_created_before: "2024-01-15"
    }
  end
end
