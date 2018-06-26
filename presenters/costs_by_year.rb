module Presenters
  class CostsByYear < BasePresenter
    def initialize(launches)
      @launches = launches
    end

    def print
      binding.pry
      hsh = launches.group_by { |h| Date.parse h[:date] }.map do |k,v|
        {:created => k.to_s,:cost => v.map {|h1| h1[:cost]}.inject(:+)}
      end
      hsh
    end
  end
end