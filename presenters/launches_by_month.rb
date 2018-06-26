module Presenters
  class LaunchesByMonth < BasePresenter


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

      (1..12).each do |month|
        month_counter[month] = 0 if !month_counter.key?(month)
      end

      super(month_counter.sort)
    end

    private

    attr_reader :launches, :month_counter
  end
end