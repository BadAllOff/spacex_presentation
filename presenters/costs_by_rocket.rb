module Presenters
  class CostsByRocket < BasePresenter
    def initialize(costs)
      @costs = costs
    end

    def print
      super(costs)
    end

    private
    attr_reader :costs
  end
end