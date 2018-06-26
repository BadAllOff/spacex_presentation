module Presenters
  class CostsByYear < BasePresenter
    def initialize(launches)
      @launches = launches
      @costs_by_year = Hash.new
    end

    def print
      launches.map do |launch|
        costs_by_year[launch.date.year] ||= 0
        costs_by_year[launch.date.year] += launch.cost if launch.success
      end
      first_year = costs_by_year.sort.first[0]
      last_year = costs_by_year.sort.last[0]

      (first_year..last_year).map do |year|
        costs_by_year[year] ||= 0
      end

      super(costs_by_year.sort)
    end

    private

    attr_reader :launches, :costs_by_year
    end
end