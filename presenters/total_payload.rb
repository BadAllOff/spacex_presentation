module Presenters
  class TotalPayload

    def initialize(launches, payload)
      @launches = launches
      @payload = payload
    end

    def print
      launches.map do |launch|
        @payload += launch.payload_weight if launch.success
      end
      puts @payload
    end

    private

    attr_reader :launches
  end
end