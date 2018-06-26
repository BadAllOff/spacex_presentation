module Presenters
  class TotalPayload

    def initialize(launches)
      @launches = launches
      @payload = 0
    end

    def print
      launches.map { |launch| @payload += launch.payload_weight if launch.success }
    end

    private

    attr_reader :launches
  end
end