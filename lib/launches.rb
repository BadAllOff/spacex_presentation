class Launches
  def initialize(all_launches, all_rockets)
    @all_launches_json = all_launches
    @all_rockets_json = all_rockets
  end

  def count_by_months
    launches_per_month
  end

  def total_payload_in_kilograms
    all_payloads = []
    all_launches_json.each do |l|
      all_payloads << l.rocket.second_stage.payloads.first.payload_mass_kg\
      unless l.rocket.second_stage.payloads.first.payload_mass_kg.nil?
    end

    all_payloads.sum
  end

  def rocket_cost_per_launch
    all_rockets_json
  end

  def annual_costs
    first_year, last_year, rockets_per_year = get_launches_dates_and_counts(all_launches_json)
    get_launch_costs_per_year(rockets_per_year, rockets_price_list, first_year, last_year)
  end

  private

  def get_launches_dates_and_counts(all_launches_json)

    first_year, last_year = nil
    rockets_per_year = {}

    all_launches_json.each do |launch|
      year        = launch.launch_date_utc[0..3].to_s
      first_year  ||= year
      last_year   = year
      rocket_id   = launch.rocket.rocket_id

      rockets_per_year_list rockets_per_year, rocket_id, year
    end
    [first_year, last_year, rockets_per_year]
  end

  def rockets_per_year_list(rockets_per_year, rocket_id, year)
    if rockets_per_year[year.to_s].nil?
      rockets_per_year[year.to_s] = { rocket_id.to_s => 1 }
    elsif rockets_per_year[year.to_s][rocket_id.to_s].nil?
      rockets_per_year[year.to_s][rocket_id.to_s] = 1
    else
      rockets_per_year[year.to_s][rocket_id.to_s] += 1
    end
  end

  def get_launch_costs_per_year(launches_count_per_year, rockets_price_list, first_year, last_year)
    costs = {}

    launches_count_per_year.each do |year, rockets|
      costs[year.to_s] = 0 if costs[year.to_s].nil?
      rockets.each do |rocket_id, count|
        costs[year.to_s] += rockets_price_list[rocket_id.to_s] * count
      end
    end

    match_dates_and_expenses(first_year, last_year, costs)
  end

  def match_dates_and_expenses(first_year, last_year, costs)
    (first_year..last_year).each do |current_year|
      costs[current_year.to_s] = 0 unless costs[current_year.to_s]
    end
    costs.sort
  end

  def rockets_price_list
    price_list = {}
    all_rockets_json.each do |rocket|
      price_list[(rocket.id).to_s] = rocket.cost_per_launch
    end
    price_list
  end

  def launches_per_month
    launches_per_month = count_by_month(Hash.new(0))
    launches_per_month.sort
  end

  def count_by_month(hash_counter)
    all_launches_json.each do |launch|
      month = launch.launch_date_utc[5..6].to_s
      hash_counter[:"#{month}"] += 1
    end
    hash_counter
  end

  def all_launches_json
    JSON.parse(@all_launches_json.body, object_class: OpenStruct)
  end

  def all_rockets_json
    JSON.parse(@all_rockets_json.body, object_class: OpenStruct)
  end
end
