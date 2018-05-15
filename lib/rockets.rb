class Rockets
  def initialize(all_rockets)
    @all_rockets_json = all_rockets
  end

  def rockets_price_list
    price_list = {}
    all_rockets_json.map do |rocket|
      price_list[(rocket.id).to_s] = rocket.cost_per_launch
    end
    price_list
  end

  def rocket_cost_per_launch
    all_rockets_json
  end

  private

  def all_rockets_json
    JSON.parse(@all_rockets_json.body, object_class: OpenStruct)
  end
end