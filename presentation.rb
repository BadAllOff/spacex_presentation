require 'pry'
require 'pp'
require './lib/spacex_api'
require './lib/launches'

class Presentation

  def initialize
    @spacex = SpacexApi.new
    @launches = Launches.new(@spacex.launches, @spacex.rockets)
  end

  def start_presentation
    count_by_months
    total_payload_in_kilograms
    rocket_cost_per_launch
    annual_costs
  end

  # can be used separately
  def count_by_months
    launches.count_by_months.each do |key, value|
      puts "#{key} #{value}"
    end
    nil
  end

  def total_payload_in_kilograms
    puts launches.total_payload_in_kilograms
    nil
  end

  def rocket_cost_per_launch
    launches.rocket_cost_per_launch.each do |rocket|
      puts "#{rocket.name} #{rocket.cost_per_launch}"
    end
    nil
  end

  def annual_costs
    launches.annual_costs.each do |year, expenditure|
      puts %(#{year} #{expenditure} )
    end
    nil
  end

  private

  def launches
    @launches
  end
end

presentation = Presentation.new
puts presentation.start_presentation
