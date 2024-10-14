require 'rails_helper'
require 'timecop'

RSpec.describe Course, type: :model do
  let(:actual_time) { Time.local(2024, 1, 5) }

  it 'validates presence of title' do
    course = Course.new(params(title: nil))

    expect(course.valid?).to be false
  end

  it 'validates presence of description' do
    course = Course.new(params(description: nil))

    expect(course.valid?).to be false
  end

  it 'validates presence of end date' do
    course = Course.new(params(end_date: nil))

    expect(course.valid?).to be false
  end

  it 'permits creation of course when all params is valid' do
    course = Course.new(params)

    expect(course.valid?).to be true
  end

  describe 'when end date is after actual date' do
    it 'returns that course is active' do
      Timecop.freeze(actual_time) do
        course = Course.new(end_date: Date.new(2024, 1, 6))

        expect(course.active?).to eq(true)
      end
    end
  end

  describe 'when end date is before actual date' do
    it 'returns that course is not active' do
      Timecop.freeze(actual_time) do
        course = Course.new(end_date: Date.new(2024, 1, 4))

        expect(course.active?).to eq(false)
      end
    end
  end

  private

  def params(
    title: 'title',
    description: 'description',
    end_date: actual_time
  )
    {
      title: title,
      description: description,
      end_date: end_date
    }
  end
end
