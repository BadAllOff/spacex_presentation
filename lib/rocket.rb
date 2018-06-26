class Rocket
  attr_reader :payload, :rocket_name

  def self.parse(json)
    new(
        rocket_name: json['rocket_name'],
        payload: payloads(json['second_stage']['payloads'] ||= 0)
    )
  end

  def initialize(rocket_name:, payload:)
    @payload     = payload
    @rocket_name = rocket_name
  end

  def self.payloads(payload_weight)
    payloads = payload_weight.inject(0){ |sum,x| sum + x['payload_mass_kg'] if x['payload_mass_kg'] }
    payloads ? payloads : 0
  end
end