class NotEnoughDataError < StandardError
  def initialize(filters)
    super("Could not find any courses with passed filters: #{filters}")
  end
end
