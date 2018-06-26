class Rocket
  attr_reader :payload, :rocket_name

  def self.parse(json)
    new(
        rocket_name: json['rocket_name'],
        payload: payload_weight(json['second_stage']['payloads'])
    )
  end

  def initialize(rocket_name:, payload:)
    @payload      = payload
    @rocket_name   = rocket_name
  end

  def self.payload_weight(payloads)
    # binding.pry
    payloads.inject(0){ |sum,x| sum + x['payload_mass_kg'] if x['payload_mass_kg'] }
  end
end