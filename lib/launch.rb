require_relative 'rocket'

class Launch
  attr_reader :date, :rocket, :success, :cost

  def self.parse(json, rocket_costs)
    new(
      date: Time.at(json['launch_date_unix']),
      rocket: Rocket.parse(json['rocket']),
      success: json['launch_success'],
      cost: rocket_costs[json['rocket']['rocket_name']]
    )
  end

  def initialize(date:, rocket:, success:, cost:)
    @date     = date
    @rocket   = rocket
    @success  = success
    @cost     = cost
  end

  def payload_weight
    success ? rocket.payload_weight : 0
  end
end