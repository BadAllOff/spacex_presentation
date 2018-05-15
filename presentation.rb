require 'pry'
require 'pp'
require './lib/spacex_api'
require './lib/launches'
require './lib/rockets'

class Presentation

  def initialize
    @spacex = SpacexApi.new
    @rockets = Rockets.new(@spacex.rockets)
    @launches = Launches.new(@spacex.launches, @rockets)
  end

  def start_presentation
    count_by_months
    total_payload_in_kilograms
    rocket_cost_per_launch
    annual_costs
  end

  # can be used separately
  def count_by_months
    print_each_row(launches.count_by_months)
    nil
  end

  def total_payload_in_kilograms
    puts launches.total_payload_in_kilograms
    nil
  end

  def rocket_cost_per_launch
    rockets.rocket_cost_per_launch.each do |rocket|
      puts "#{rocket.name} #{rocket.cost_per_launch}"
    end
    nil
  end

  def annual_costs
    print_each_row(launches.annual_costs)
    nil
  end

  private

  def print_each_row(data)
    data.each do |key, val|
      puts %(#{key} #{val} )
    end
  end

  def launches
    @launches
  end

  def rockets
    @rockets
  end
end

presentation = Presentation.new
puts presentation.start_presentation
