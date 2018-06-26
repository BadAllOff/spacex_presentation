module Presenters
  class TotalPayload

    def initialize(launches)
      @launches = launches
      @month_counter = Hash.new
    end

    def print
      launches.map do |launch|
        month = launch.date.month
        if month_counter[month]
          month_counter[month] += 1
        else
          month_counter[month] = 1
        end
      end
      pp month_counter.sort
    end

    private

    attr_reader :launches, :month_counter
  end
end